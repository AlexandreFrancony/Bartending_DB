# Bartending V2 - Database
# PostgreSQL 15 on Alpine (ARM64 compatible for Raspberry Pi 4)

FROM postgres:15-alpine

# Set locale for French text support
ENV LANG=fr_FR.UTF-8
ENV LC_ALL=fr_FR.UTF-8

# Copy initialization scripts
# PostgreSQL automatically runs .sql files in /docker-entrypoint-initdb.d/
# in alphabetical order on first startup
COPY init/ /docker-entrypoint-initdb.d/

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD pg_isready -U ${POSTGRES_USER:-bartender} -d ${POSTGRES_DB:-bartending} || exit 1

# Expose PostgreSQL port
EXPOSE 5432
