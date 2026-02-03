# Bartending V2 - Database

## Project Overview

This repository contains the PostgreSQL database configuration for the Bartending V2 application. It is designed to run in a Docker container on a Raspberry Pi 4.

## Architecture

Bartending V2 is split into 3 separate repositories:
- **Bartending_DB** (this repo): PostgreSQL database with Docker configuration
- **Bartending_Back**: Express.js REST API backend
- **Bartending_Front**: React frontend application

All three services are designed to run as Docker containers and communicate over a shared Docker network.

## Database Schema

### Tables

1. **cocktails** - Drink recipes with ingredients stored as JSONB
   - `id` (VARCHAR, PK) - Unique identifier (kebab-case)
   - `name` (VARCHAR) - Display name (supports unicode)
   - `image` (VARCHAR) - Image filename
   - `ingredients` (JSONB) - Array of {name, quantity, category}
   - `available` (BOOLEAN) - Whether the cocktail can be ordered
   - `created_at`, `updated_at` (TIMESTAMP)

2. **customers** - Customer information
   - `id` (SERIAL, PK) - Auto-increment ID
   - `name` (VARCHAR) - Customer name
   - `email` (VARCHAR, optional) - Contact email
   - `phone` (VARCHAR, optional) - Contact phone
   - `created_at` (TIMESTAMP)

3. **orders** - Order records linking customers to cocktails
   - `id` (SERIAL, PK) - Auto-increment ID
   - `customer_id` (FK) - References customers.id
   - `cocktail_id` (FK) - References cocktails.id
   - `status` (ENUM) - 'pending', 'preparing', 'ready', 'completed', 'cancelled'
   - `notes` (TEXT, optional) - Special requests
   - `created_at`, `completed_at` (TIMESTAMP)

### Ingredient Categories

Ingredients use these category values:
- `Alcool` - Spirits and liquors
- `Fruits` - Juices and fruit products
- `Sucrant` - Syrups and sweeteners
- `Diluant` - Mixers (tonic, soda, etc.)
- `Garniture` - Garnishes
- `JNPR` - JNPR brand non-alcoholic spirits

## File Structure

```
Bartending_DB/
├── CLAUDE.md              # This file
├── docker-compose.yml     # Container orchestration
├── Dockerfile             # PostgreSQL image configuration
├── .env.example           # Environment variables template
├── init/
│   ├── 01-schema.sql      # Table definitions
│   └── 02-seed-cocktails.sql  # Initial cocktail data (31 cocktails)
└── migrations/            # Future schema changes
```

## Docker Configuration

- **Base Image**: postgres:15-alpine (ARM64 compatible)
- **Default Port**: 5432
- **Data Volume**: `bartending_db_data` for persistence
- **Health Check**: pg_isready command

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| POSTGRES_USER | Database user | bartender |
| POSTGRES_PASSWORD | Database password | (required) |
| POSTGRES_DB | Database name | bartending |

## Development Commands

```bash
# Start the database
docker-compose up -d

# View logs
docker-compose logs -f

# Connect to database
docker exec -it bartending_db psql -U bartender -d bartending

# Stop and remove containers
docker-compose down

# Reset database (removes all data)
docker-compose down -v
```

## Notes

- The database auto-seeds 31 cocktails on first startup
- All cocktails are set to `available = true` by default
- Ingredients are stored as JSONB for flexible querying
- Foreign key constraints ensure data integrity
