# Bartending V2 - Database

## Project Overview

This repository contains the PostgreSQL database configuration for the Bartending V2 (Tipsy) application. It runs as a centralized Docker container on the ProDesk, shared by all francony.fr services.

## Architecture

Bartending V2 is split into 3 separate repositories:
- **Bartending_DB** (this repo): PostgreSQL database with Docker configuration
- **Bartending_Back**: Express.js REST API backend
- **Bartending_Front**: React frontend application

All three services run as Docker containers on the ProDesk and communicate over `bartending_network`. The database is centralized in the Infra stack and also hosts `mtg_collection` and `cashalot` databases.

## Database Schema

### Enums

- **order_status**: `pending`, `preparing`, `ready`, `completed`, `cancelled`
- **ingredient_category**: `Alcool`, `Fruits`, `Sucrant`, `Diluant`, `Garniture`, `JNPR`
- **user_role**: `user`, `admin`

### Tables

1. **cocktails** - Drink recipes with ingredients stored as JSONB
   - `id` (VARCHAR 100, PK) - Unique identifier (kebab-case)
   - `name` (VARCHAR 255) - Display name (supports unicode)
   - `image` (VARCHAR 255) - Image filename
   - `ingredients` (JSONB) - Array of `{name, quantity, category}`
   - `available` (BOOLEAN, default true)
   - `created_at`, `updated_at` (TIMESTAMPTZ)

2. **users** - User authentication and profiles (JWT-based)
   - `id` (SERIAL, PK)
   - `username` (VARCHAR 50, UNIQUE) - Min 3 characters
   - `email` (VARCHAR 255, UNIQUE) - Validated format
   - `password_hash` (VARCHAR 255) - bcrypt
   - `role` (user_role, default 'user')
   - `reset_token` (VARCHAR 255) - Password reset token
   - `reset_token_expiry` (TIMESTAMPTZ)
   - `favorites` (JSONB, default '[]') - Array of favorite cocktail IDs
   - `created_at`, `updated_at` (TIMESTAMPTZ)

3. **orders** - Order records linking users to cocktails
   - `id` (SERIAL, PK)
   - `user_id` (FK → users.id, ON DELETE CASCADE)
   - `cocktail_id` (FK → cocktails.id, ON DELETE RESTRICT)
   - `status` (order_status, default 'pending')
   - `notes` (TEXT) - Special requests
   - `created_at` (TIMESTAMPTZ)
   - `completed_at` (TIMESTAMPTZ) - Auto-set via trigger

4. **available_ingredients** - Inventory management
   - `id` (SERIAL, PK)
   - `name` (VARCHAR 255, UNIQUE)
   - `in_stock` (BOOLEAN, default true)
   - `created_at`, `updated_at` (TIMESTAMPTZ)

### Views

- **orders_detail** - Joined order info (order + user + cocktail)
- **cocktail_pending_orders** - Aggregate pending orders per cocktail
- **cocktails_with_availability** - Cocktails with computed `can_be_made` flag based on ingredient stock

### Functions & Triggers

- `update_updated_at_column()` - Auto-updates `updated_at` on cocktails, users, available_ingredients
- `set_order_completed_at()` - Auto-sets `completed_at` when order status → 'completed'
- `cocktail_is_available(JSONB)` - Checks if all ingredients are in stock (case-insensitive)

### Indexes

- GIN index on `cocktails.name` (French full-text search)
- GIN index on `cocktails.ingredients` (JSONB)
- GIN index on `users.favorites` (JSONB)
- B-tree indexes on orders (status, user_id, cocktail_id, created_at DESC)
- B-tree indexes on users (username, email)

## File Structure

```
Bartending_DB/
├── CLAUDE.md              # This file
├── README.md              # Project documentation
├── docker-compose.yml     # Standalone container (dev)
├── Dockerfile             # PostgreSQL image configuration
├── .env.example           # Environment variables template
└── init/
    ├── 01-schema.sql      # Tables, enums, indexes, views, functions, triggers
    ├── 02-seed-cocktails.sql  # 68 cocktail recipes (JSONB)
    ├── 02-users.sql       # Users table, user_role enum, orders migration
    ├── 03-ingredients.sql # available_ingredients table, availability view
    └── 04-favorites.sql   # User favorites column and GIN index
```

## Docker Configuration

- **Base Image**: postgres:15-alpine
- **Default Port**: 5432
- **Health Check**: pg_isready command
- **Production**: Runs centralized in Infra stack (`~/Hosting/Infra/docker-compose.yml`)
- **Development**: Can run standalone via local `docker-compose.yml`

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| POSTGRES_USER | Database superuser | bartender |
| POSTGRES_PASSWORD | Database password | (required) |
| POSTGRES_DB | Default database | bartending |

## Development Commands

```bash
# Start the database (standalone)
docker compose up -d

# Connect to database
docker exec -it postgres psql -U bartender -d bartending

# Stop and remove containers
docker compose down

# Reset database (removes all data)
docker compose down -v
```

## Notes

- 68 cocktails are seeded on first startup (13 JNPR non-alcoholic + 55 classic)
- All cocktails default to `available = true`
- Ingredients are stored as JSONB for flexible querying
- Full-text search uses French language configuration
- The `cocktails_with_availability` view computes real-time availability based on ingredient stock
- In production, this DB is one of 3 databases in the centralized PostgreSQL container (alongside mtg_collection and cashalot)
