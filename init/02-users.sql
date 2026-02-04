-- Bartending V2 - Users & Authentication
-- This migration adds user authentication support

-- ============================================
-- USER ROLES ENUM
-- ============================================
CREATE TYPE user_role AS ENUM ('user', 'admin');

-- ============================================
-- USERS TABLE
-- ============================================
-- Replaces the customers table for authenticated orders
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role user_role NOT NULL DEFAULT 'user',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    -- Constraints
    CONSTRAINT users_username_unique UNIQUE (username),
    CONSTRAINT users_email_unique UNIQUE (email),
    CONSTRAINT users_username_length CHECK (char_length(username) >= 3),
    CONSTRAINT users_email_format CHECK (
        email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
    )
);

-- Indexes for login queries (lookup by username or email)
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_email ON users(email);

-- Trigger for auto-updating updated_at
CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- UPDATE ORDERS TABLE
-- ============================================
-- Change customer_id to user_id and update foreign key

-- First, drop the old foreign key constraint
ALTER TABLE orders DROP CONSTRAINT IF EXISTS fk_orders_customer;

-- Rename the column
ALTER TABLE orders RENAME COLUMN customer_id TO user_id;

-- Add new foreign key to users table
ALTER TABLE orders ADD CONSTRAINT fk_orders_user
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;

-- Update the index name for clarity
DROP INDEX IF EXISTS idx_orders_customer;
CREATE INDEX idx_orders_user ON orders(user_id);

-- ============================================
-- DROP OLD CUSTOMERS TABLE
-- ============================================
-- No historical data to preserve
DROP TABLE IF EXISTS customers CASCADE;

-- ============================================
-- UPDATE VIEWS
-- ============================================
-- Recreate orders_detail view with users instead of customers
DROP VIEW IF EXISTS orders_detail;
CREATE VIEW orders_detail AS
SELECT
    o.id AS order_id,
    o.status,
    o.notes,
    o.created_at AS order_time,
    o.completed_at,
    u.id AS user_id,
    u.username AS user_name,
    u.email AS user_email,
    ck.id AS cocktail_id,
    ck.name AS cocktail_name,
    ck.image AS cocktail_image,
    ck.ingredients AS cocktail_ingredients
FROM orders o
JOIN users u ON o.user_id = u.id
JOIN cocktails ck ON o.cocktail_id = ck.id;

-- Drop the old view that referenced customers
DROP VIEW IF EXISTS cocktail_pending_orders;
CREATE VIEW cocktail_pending_orders AS
SELECT
    ck.id,
    ck.name,
    COUNT(o.id) AS pending_count
FROM cocktails ck
LEFT JOIN orders o ON ck.id = o.cocktail_id AND o.status = 'pending'
GROUP BY ck.id, ck.name;
