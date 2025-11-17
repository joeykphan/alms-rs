#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE alm_test;
    GRANT ALL PRIVILEGES ON DATABASE alm_test TO postgres;
EOSQL

echo "Test database created successfully"
