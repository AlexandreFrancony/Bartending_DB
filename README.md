# Tipsy - Database

PostgreSQL database schema and seed data for the Tipsy cocktail ordering application.

## Features

- **PostgreSQL 15+** - Modern relational database with JSONB support
- **Migration-ready** - Organized SQL files for schema and data
- **Full-text Search** - French language text search on cocktail names
- **Auto-timestamps** - Triggers for automatic `updated_at` management
- **31 Pre-seeded Cocktails** - Ready-to-use cocktail data

## Schema Overview

### Tables

| Table | Description |
|-------|-------------|
| `cocktails` | Cocktail recipes with JSONB ingredients |
| `users` | User accounts with authentication |
| `orders` | Order tracking with status management |

### Enums

| Enum | Values |
|------|--------|
| `order_status` | pending, preparing, ready, completed, cancelled |
| `ingredient_category` | Alcool, Fruits, Sucrant, Diluant, Garniture, JNPR |
| `user_role` | user, admin |

### Views

| View | Description |
|------|-------------|
| `orders_detail` | Orders with user and cocktail details joined |
| `cocktail_pending_orders` | Pending order count per cocktail |

## Project Structure

```
Bartending_DB/
├── init/                        # Initialization scripts (run in order)
│   ├── 01-schema.sql           # Core tables, indexes, triggers
│   ├── 02-users.sql            # User authentication schema
│   ├── 02-seed-cocktails.sql   # 31 cocktails seed data
│   └── 03-ingredients.sql      # Ingredients reference data
├── migrations/                  # Future migrations
├── .env.example                # Environment template
├── docker-compose.yml          # Standalone DB container
├── Dockerfile                  # Custom PostgreSQL image
└── README.md
```

## Getting Started

### Prerequisites

- Docker and Docker Compose
- Or PostgreSQL 15+ installed locally

### With Docker (Recommended)

1. **Clone the repository**
   ```bash
   git clone https://github.com/AlexandreFrancony/Bartending_DB.git
   cd Bartending_DB
   ```

2. **Configure environment**
   ```bash
   cp .env.example .env
   # Edit .env with secure credentials
   ```

3. **Start the database**
   ```bash
   docker compose up -d
   ```

The database will be available at `localhost:5432` with the configured credentials.

### Local PostgreSQL

1. **Create the database**
   ```bash
   createdb bartending
   ```

2. **Run initialization scripts**
   ```bash
   psql -d bartending -f init/01-schema.sql
   psql -d bartending -f init/02-users.sql
   psql -d bartending -f init/02-seed-cocktails.sql
   psql -d bartending -f init/03-ingredients.sql
   ```

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `POSTGRES_USER` | Database user | `bartender` |
| `POSTGRES_PASSWORD` | Database password | Required |
| `POSTGRES_DB` | Database name | `bartending` |
| `DB_PORT` | Exposed port | `5432` |

## Schema Details

### Cocktails Table

```sql
CREATE TABLE cocktails (
    id VARCHAR(100) PRIMARY KEY,     -- kebab-case (e.g., "mojito")
    name VARCHAR(255) NOT NULL,
    image VARCHAR(255),
    ingredients JSONB NOT NULL DEFAULT '[]',
    available BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE,
    updated_at TIMESTAMP WITH TIME ZONE
);
```

**Ingredients JSONB Format:**
```json
[
  { "name": "Rhum", "quantity": "45ml", "category": "Alcool" },
  { "name": "Citron vert", "quantity": "30ml", "category": "Fruits" },
  { "name": "Menthe", "quantity": "6 feuilles", "category": "Garniture" }
]
```

### Users Table

```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role user_role NOT NULL DEFAULT 'user',
    reset_token VARCHAR(255),
    reset_token_expiry TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE,
    updated_at TIMESTAMP WITH TIME ZONE
);
```

### Orders Table

```sql
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id),
    cocktail_id VARCHAR(100) NOT NULL REFERENCES cocktails(id),
    status order_status NOT NULL DEFAULT 'pending',
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE,
    completed_at TIMESTAMP WITH TIME ZONE
);
```

## Useful Queries

**Get pending orders with details:**
```sql
SELECT * FROM orders_detail WHERE status = 'pending' ORDER BY order_time;
```

**Get available cocktails with alcohol:**
```sql
SELECT name FROM cocktails
WHERE available = true
AND ingredients @> '[{"category": "Alcool"}]';
```

**Get user order history:**
```sql
SELECT * FROM orders_detail WHERE user_id = 1 ORDER BY order_time DESC;
```

## Related Repositories

- [Bartending_Front](https://github.com/AlexandreFrancony/Bartending_Front) - React frontend
- [Bartending_Back](https://github.com/AlexandreFrancony/Bartending_Back) - Express API
- [Bartending_Deploy](https://github.com/AlexandreFrancony/Bartending_Deploy) - Docker deployment
- [Infra](https://github.com/AlexandreFrancony/Infra) - Central reverse proxy

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.
