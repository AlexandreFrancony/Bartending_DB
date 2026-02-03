-- Bartending V2 - Ingredients Management
-- This adds a table to track which ingredients are available

-- ============================================
-- AVAILABLE INGREDIENTS TABLE
-- ============================================
CREATE TABLE available_ingredients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    in_stock BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Index for searching ingredients
CREATE INDEX idx_available_ingredients_name ON available_ingredients(name);
CREATE INDEX idx_available_ingredients_in_stock ON available_ingredients(in_stock);

-- Trigger to auto-update updated_at
CREATE TRIGGER update_available_ingredients_updated_at
    BEFORE UPDATE ON available_ingredients
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- FUNCTION: Check if a cocktail can be made
-- ============================================
CREATE OR REPLACE FUNCTION cocktail_is_available(cocktail_ingredients JSONB)
RETURNS BOOLEAN AS $$
DECLARE
    ingredient JSONB;
    ingredient_name TEXT;
    is_available BOOLEAN;
BEGIN
    -- If no ingredients, consider it available
    IF cocktail_ingredients IS NULL OR jsonb_array_length(cocktail_ingredients) = 0 THEN
        RETURN TRUE;
    END IF;

    -- Check each ingredient
    FOR ingredient IN SELECT * FROM jsonb_array_elements(cocktail_ingredients)
    LOOP
        ingredient_name := ingredient->>'name';

        -- Check if this ingredient is in stock
        SELECT ai.in_stock INTO is_available
        FROM available_ingredients ai
        WHERE LOWER(ai.name) = LOWER(ingredient_name);

        -- If ingredient not found in our list or not in stock, cocktail is unavailable
        IF is_available IS NULL OR is_available = FALSE THEN
            RETURN FALSE;
        END IF;
    END LOOP;

    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;

-- ============================================
-- VIEW: Cocktails with computed availability
-- ============================================
CREATE OR REPLACE VIEW cocktails_with_availability AS
SELECT
    c.*,
    cocktail_is_available(c.ingredients) AS can_be_made,
    (
        SELECT jsonb_agg(
            jsonb_build_object(
                'name', ing->>'name',
                'quantity', ing->>'quantity',
                'category', ing->>'category',
                'in_stock', COALESCE(
                    (SELECT ai.in_stock FROM available_ingredients ai WHERE LOWER(ai.name) = LOWER(ing->>'name')),
                    FALSE
                )
            )
        )
        FROM jsonb_array_elements(c.ingredients) AS ing
    ) AS ingredients_with_stock
FROM cocktails c;

-- ============================================
-- SEED: Extract all unique ingredients from cocktails
-- ============================================
INSERT INTO available_ingredients (name, in_stock)
SELECT DISTINCT ing->>'name', TRUE
FROM cocktails, jsonb_array_elements(ingredients) AS ing
ON CONFLICT (name) DO NOTHING;

-- Verify
DO $$
DECLARE
    ingredient_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO ingredient_count FROM available_ingredients;
    RAISE NOTICE 'Extracted % unique ingredients from cocktails', ingredient_count;
END $$;
