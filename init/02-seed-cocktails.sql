-- Bartending V2 - Seed Data for Cocktails
-- Auto-generated from cocktails.json (68 cocktails)

INSERT INTO cocktails (id, name, image, ingredients, available) VALUES

-- JNPR Non-Alcoholic Cocktails
('mitsubachi', 'ミツバチ (Mistsubachi)', 'mitsubachi.jpg', '[{"name": "Gin", "quantity": "5cl", "category": "Alcool"}, {"name": "Yuzu honey", "quantity": "3 cl", "category": "Sucrant"}]', TRUE),

('Virgin Bee''s Knees', '白い蜂 (Shiroi hachi)', 'bees-knees.jpg', '[{"name": "JNPR n°3", "quantity": "5cl", "category": "JNPR"}, {"name": "Jus de citron", "quantity": "2.5 cl", "category": "Fruits"}, {"name": "Sirop de Miel", "quantity": "2.5 cl", "category": "Sucrant"}]', TRUE),

('ceci-nest-pas-un-ginto', 'Ceci n''est pas un GinTo', 'ceci-nest-pas-un-ginto.jpg', '[{"name": "JNPR n°1", "quantity": "3 cl", "category": "JNPR"}, {"name": "Tonic", "quantity": "6 cl", "category": "Diluant"}, {"name": "Zeste de citron", "quantity": "1", "category": "Garniture"}]', TRUE),

('ceci-nest-pas-un-spritz', 'Ceci n''est pas un Spritz', 'ceci-nest-pas-un-spritz.jpg', '[{"name": "BTTR n°1", "quantity": "3 cl", "category": "JNPR"}, {"name": "Eau pétillante", "quantity": "6 cl", "category": "Diluant"}]', TRUE),

('ceci-nest-pas-un-mule', 'Ceci n''est pas un Mule', 'ceci-nest-pas-un-mule.jpg', '[{"name": "JNPR n°2", "quantity": "4 cl", "category": "JNPR"}, {"name": "Ginger Beer", "quantity": "10 cl", "category": "Diluant"}, {"name": "Jus de citron vert", "quantity": "1 cl", "category": "Fruits"}]', TRUE),

('ceci-nest-pas-un-mojito', 'Ceci n''est pas un Mojito', 'ceci-nest-pas-un-mojito.jpg', '[{"name": "JNPR n°2", "quantity": "4 cl", "category": "JNPR"}, {"name": "Menthe", "quantity": "8 feuilles", "category": "Garniture"}, {"name": "Sirop de sucre", "quantity": "2 cl", "category": "Sucrant"}, {"name": "Jus de citron vert", "quantity": "2 cl", "category": "Fruits"}, {"name": "Eau pétillante", "quantity": "6 cl", "category": "Diluant"}]', TRUE),

('ceci-nest-pas-un-cosmopolitan', 'Ceci n''est pas un Cosmopolitan', 'ceci-nest-pas-un-cosmopolitan.jpg', '[{"name": "JNPR n°1", "quantity": "4 cl", "category": "JNPR"}, {"name": "Jus de cranberry", "quantity": "2 cl", "category": "Fruits"}, {"name": "Jus de citron vert", "quantity": "1 cl", "category": "Fruits"}, {"name": "Sirop de sucre", "quantity": "1 cl", "category": "Sucrant"}]', TRUE),

('ceci-nest-pas-une-margarita', 'Ceci n''est pas une Margarita', 'ceci-nest-pas-une-margarita.jpg', '[{"name": "JNPR n°1", "quantity": "4 cl", "category": "JNPR"}, {"name": "Jus de citron vert", "quantity": "2 cl", "category": "Fruits"}, {"name": "Sirop d''agave", "quantity": "1 cl", "category": "Sucrant"}]', TRUE),

('ceci-nest-pas-un-negroni', 'Ceci n''est pas un Negroni', 'ceci-nest-pas-un-negroni.jpg', '[{"name": "BTTR n°1", "quantity": "3 cl", "category": "JNPR"}, {"name": "VRMH n°1", "quantity": "3 cl", "category": "JNPR"}, {"name": "JNPR n°1", "quantity": "3 cl", "category": "JNPR"}]', TRUE),

('ceci-nest-pas-un-sour', 'Ceci n''est pas un Sour', 'ceci-nest-pas-un-sour.jpg', '[{"name": "JNPR n°1", "quantity": "4 cl", "category": "JNPR"}, {"name": "Jus de citron", "quantity": "2 cl", "category": "Fruits"}, {"name": "Sirop de sucre", "quantity": "2 cl", "category": "Sucrant"}, {"name": "Blanc d''œuf", "quantity": "1", "category": "Garniture"}]', TRUE),

('ceci-nest-pas-un-basil-smash', 'Ceci n''est pas un Basil Smash', 'ceci-nest-pas-un-basil-smash.jpg', '[{"name": "JNPR n°2", "quantity": "4 cl", "category": "JNPR"}, {"name": "Jus de citron", "quantity": "2 cl", "category": "Fruits"}, {"name": "Sirop de sucre", "quantity": "2 cl", "category": "Sucrant"}, {"name": "Basilic", "quantity": "6 feuilles", "category": "Garniture"}]', TRUE),

('ceci-nest-pas-un-paloma', 'Ceci n''est pas un Paloma', 'ceci-nest-pas-un-paloma.jpg', '[{"name": "JNPR n°3", "quantity": "4 cl", "category": "JNPR"}, {"name": "Jus de pamplemousse", "quantity": "6 cl", "category": "Fruits"}, {"name": "Sirop d''agave", "quantity": "1 cl", "category": "Sucrant"}, {"name": "Eau pétillante", "quantity": "4 cl", "category": "Diluant"}]', TRUE),

-- Classic Alcoholic Cocktails
('sex-on-the-beach', 'Sex on the Beach', 'sex-on-the-beach.jpg', '[{"name": "Vodka", "quantity": "4 cl", "category": "Alcool"}, {"name": "Purée de pêches", "quantity": "1 cl", "category": "Fruits"}, {"name": "Liqueur de Chambord", "quantity": "1 cl", "category": "Alcool"}, {"name": "Jus d''orange", "quantity": "5 cl", "category": "Fruits"}, {"name": "Jus de cranberry", "quantity": "5 cl", "category": "Fruits"}]', TRUE),

('spritz', 'Spritz', 'spritz.jpg', '[{"name": "Apérol", "quantity": "12 cl", "category": "Alcool"}, {"name": "Prosecco", "quantity": "24 cl", "category": "Alcool"}, {"name": "Eau pétillante", "quantity": "4 cl", "category": "Diluant"}]', TRUE),

('bellini', 'Bellini Spritz', 'bellini.jpg', '[{"name": "Purée de pêches", "quantity": "3 cl", "category": "Fruits"}, {"name": "Prosecco", "quantity": "10 cl", "category": "Alcool"}]', TRUE),

('Hugo-spritz', 'Hugo Spritz', 'hugo-spritz.jpg', '[{"name": "Prosecco", "quantity": "10 cl", "category": "Alcool"}, {"name": "Sirop de sureau", "quantity": "2 cl", "category": "Sucrant"}, {"name": "Eau pétillante", "quantity": "3 cl", "category": "Diluant"}, {"name": "Menthe", "quantity": "6 feuilles", "category": "Garniture"}]', TRUE),

('Italicus-spritz', 'Italicus Spritz', 'italicus-spritz.jpg', '[{"name": "Italicus", "quantity": "3 cl", "category": "Alcool"}, {"name": "Prosecco", "quantity": "6 cl", "category": "Alcool"}, {"name": "Eau pétillante", "quantity": "1 cl", "category": "Diluant"}, {"name": "Jus de citron", "quantity": "1 rondelle", "category": "Fruits"}]', TRUE),

('mojito', 'Mojito', 'mojito.jpg', '[{"name": "Menthe", "quantity": "8 feuilles", "category": "Garniture"}, {"name": "Rhum blanc", "quantity": "5 cl", "category": "Alcool"}, {"name": "Sirop de sucre", "quantity": "2.5 cl", "category": "Sucrant"}, {"name": "Jus de citron vert", "quantity": "2.5 cl", "category": "Fruits"}, {"name": "Eau pétillante", "quantity": "2.5 cl", "category": "Diluant"}]', TRUE),

('margarita', 'Margarita', 'margarita.jpg', '[{"name": "Tequila", "quantity": "4 cl", "category": "Alcool"}, {"name": "Triple sec", "quantity": "2 cl", "category": "Alcool"}, {"name": "Jus de citron vert", "quantity": "2 cl", "category": "Fruits"}]', TRUE),

('bloody-mary', 'Bloody Mary', 'bloody-mary.jpg', '[{"name": "Vodka", "quantity": "5 cl", "category": "Alcool"}, {"name": "Jus de tomate", "quantity": "10 cl", "category": "Fruits"}, {"name": "Jus de citron", "quantity": "1 cl", "category": "Fruits"}, {"name": "Worcestershire sauce", "quantity": "3 traits", "category": "Garniture"}, {"name": "Tabasco", "quantity": "1 trait", "category": "Garniture"}, {"name": "Sel de céleri", "quantity": "1 pincée", "category": "Garniture"}, {"name": "Poivre", "quantity": "1 pincée", "category": "Garniture"}]', TRUE),

('moscow-mule', 'Moscow Mule', 'moscow-mule.jpg', '[{"name": "Vodka", "quantity": "6 cl", "category": "Alcool"}, {"name": "Jus de citron vert", "quantity": "1 cl", "category": "Fruits"}, {"name": "Ginger Beer", "quantity": "Complément", "category": "Diluant"}]', TRUE),

('bora-bora', 'Bora Bora', 'bora-bora.jpg', '[{"name": "Jus d''ananas", "quantity": "10 cl", "category": "Fruits"}, {"name": "Jus de fruit de la passion", "quantity": "6 cl", "category": "Fruits"}, {"name": "Jus de citron", "quantity": "1 cl", "category": "Fruits"}, {"name": "Sirop de grenadine", "quantity": "2 cl", "category": "Sucrant"}]', TRUE),

('gin-tonic', 'Gin Tonic', 'gin-tonic.jpg', '[{"name": "Gin", "quantity": "3 cl", "category": "Alcool"}, {"name": "Tonic", "quantity": "Complément", "category": "Diluant"}]', TRUE),

('old-fashioned', 'Old Fashioned', 'old-fashioned.jpg', '[{"name": "Bourbon", "quantity": "5 cl", "category": "Alcool"}, {"name": "Eau pétillante", "quantity": "0.5 cl", "category": "Diluant"}, {"name": "Angostura bitters", "quantity": "2 traits", "category": "Garniture"}]', TRUE),

('negroni', 'Negroni', 'negroni.jpg', '[{"name": "Gin", "quantity": "30 ml", "category": "Alcool"}, {"name": "Vermouth rouge", "quantity": "30 ml", "category": "Alcool"}, {"name": "Campari", "quantity": "30 ml", "category": "Alcool"}]', TRUE),

('pink-lady', 'Pink Lady', 'pink-lady.jpg', '[{"name": "Gin", "quantity": "4 cl", "category": "Alcool"}, {"name": "Sirop de grenadine", "quantity": "1 cl", "category": "Sucrant"}, {"name": "Jus de citron", "quantity": "2 cl", "category": "Fruits"}, {"name": "Blanc d''œuf", "quantity": "1", "category": "Garniture"}]', TRUE),

('bee''s-knees', 'Bee''s knees', 'bees-knees.jpg', '[{"name": "Gin", "quantity": "5 cl", "category": "Alcool"}, {"name": "Jus de citron", "quantity": "2.5 cl", "category": "Fruits"}, {"name": "Sirop de Miel", "quantity": "2.5 cl", "category": "Sucrant"}]', TRUE),

('piña-colada', 'Piña Colada', 'pina-colada.jpg', '[{"name": "Rhum blanc", "quantity": "3 cl", "category": "Alcool"}, {"name": "Crème de coco", "quantity": "3 cl", "category": "Sucrant"}, {"name": "Jus d''ananas", "quantity": "9 cl", "category": "Fruits"}, {"name": "Crème fraîche épaisse", "quantity": "2 cl", "category": "Diluant"}]', TRUE),

('cosmopolitain', 'Cosmopolitain', 'cosmopolitain.jpg', '[{"name": "Vodka", "quantity": "4 cl", "category": "Alcool"}, {"name": "Triple sec", "quantity": "2 cl", "category": "Alcool"}, {"name": "Jus de cranberry", "quantity": "2 cl", "category": "Fruits"}, {"name": "Jus de citron vert", "quantity": "1 cl", "category": "Fruits"}]', TRUE),

('blue-hawaiian', 'Blue Hawaiian', 'blue-hawaiian.jpg', '[{"name": "Rhum blanc", "quantity": "4 cl", "category": "Alcool"}, {"name": "Lait de coco", "quantity": "4 cl", "category": "Sucrant"}, {"name": "Jus d''ananas", "quantity": "8 cl", "category": "Fruits"}, {"name": "Curacao bleu", "quantity": "2 cl", "category": "Alcool"}]', TRUE),

('penicilline', 'Penicilline', 'penicilline.jpg', '[{"name": "Whisky", "quantity": "5 cl", "category": "Alcool"}, {"name": "Jus de citron", "quantity": "2.5 cl", "category": "Fruits"}, {"name": "Sirop de Miel", "quantity": "1.5 cl", "category": "Sucrant"}]', TRUE);

-- Verify the seed data
DO $$
DECLARE
    cocktail_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO cocktail_count FROM cocktails;
    RAISE NOTICE 'Seeded % cocktails successfully', cocktail_count;
END $$;
