-- Bartending V2 Database Schema
-- PostgreSQL 15+

-- Create custom enum for order status
CREATE TYPE order_status AS ENUM ('pending', 'preparing', 'ready', 'completed', 'cancelled');

-- Create custom enum for ingredient categories
CREATE TYPE ingredient_category AS ENUM ('Alcool', 'Fruits', 'Sucrant', 'Diluant', 'Garniture', 'JNPR');

-- ============================================
-- COCKTAILS TABLE
-- ============================================
CREATE TABLE cocktails (
    id VARCHAR(100) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    image VARCHAR(255),
    ingredients JSONB NOT NULL DEFAULT '[]',
    available BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Index for searching available cocktails
CREATE INDEX idx_cocktails_available ON cocktails(available);

-- Index for full-text search on name
CREATE INDEX idx_cocktails_name ON cocktails USING gin(to_tsvector('french', name));

-- Index for querying ingredients (JSONB)
CREATE INDEX idx_cocktails_ingredients ON cocktails USING gin(ingredients);

-- ============================================
-- CUSTOMERS TABLE
-- ============================================
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(50),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    -- Constraints
    CONSTRAINT customers_email_unique UNIQUE (email),
    CONSTRAINT customers_email_format CHECK (
        email IS NULL OR email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
    )
);

-- Index for searching customers by name
CREATE INDEX idx_customers_name ON customers(name);

-- ============================================
-- ORDERS TABLE
-- ============================================
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    cocktail_id VARCHAR(100) NOT NULL,
    status order_status NOT NULL DEFAULT 'pending',
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP WITH TIME ZONE,

    -- Foreign key constraints
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_orders_cocktail
        FOREIGN KEY (cocktail_id)
        REFERENCES cocktails(id)
        ON DELETE RESTRICT
);

-- Index for querying orders by status
CREATE INDEX idx_orders_status ON orders(status);

-- Index for querying orders by customer
CREATE INDEX idx_orders_customer ON orders(customer_id);

-- Index for querying orders by cocktail
CREATE INDEX idx_orders_cocktail ON orders(cocktail_id);

-- Index for date-based queries
CREATE INDEX idx_orders_created_at ON orders(created_at DESC);

-- ============================================
-- FUNCTIONS
-- ============================================

-- Function to update the updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Trigger to auto-update updated_at on cocktails
CREATE TRIGGER update_cocktails_updated_at
    BEFORE UPDATE ON cocktails
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Function to set completed_at when order status changes to 'completed'
CREATE OR REPLACE FUNCTION set_order_completed_at()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'completed' AND OLD.status != 'completed' THEN
        NEW.completed_at = CURRENT_TIMESTAMP;
    END IF;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Trigger to auto-set completed_at
CREATE TRIGGER set_orders_completed_at
    BEFORE UPDATE ON orders
    FOR EACH ROW
    EXECUTE FUNCTION set_order_completed_at();

-- ============================================
-- VIEWS
-- ============================================

-- View for orders with customer and cocktail details
CREATE VIEW orders_detail AS
SELECT
    o.id AS order_id,
    o.status,
    o.notes,
    o.created_at AS order_time,
    o.completed_at,
    c.id AS customer_id,
    c.name AS customer_name,
    c.email AS customer_email,
    ck.id AS cocktail_id,
    ck.name AS cocktail_name,
    ck.image AS cocktail_image,
    ck.ingredients AS cocktail_ingredients
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN cocktails ck ON o.cocktail_id = ck.id;

-- View for pending orders count by cocktail
CREATE VIEW cocktail_pending_orders AS
SELECT
    ck.id,
    ck.name,
    COUNT(o.id) AS pending_count
FROM cocktails ck
LEFT JOIN orders o ON ck.id = o.cocktail_id AND o.status = 'pending'
GROUP BY ck.id, ck.name;
