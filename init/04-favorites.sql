-- Bartending V2 - User Favorites
-- Adds favorites column to users table for syncing favorites across devices

-- Add favorites column (array of cocktail IDs stored as JSONB)
ALTER TABLE users ADD COLUMN IF NOT EXISTS favorites JSONB DEFAULT '[]'::jsonb;

-- Create index for faster favorites lookups
CREATE INDEX IF NOT EXISTS idx_users_favorites ON users USING GIN (favorites);
