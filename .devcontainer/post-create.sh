#!/bin/bash
set -e

echo "Running post-create setup..."

echo "Installing Rust dependencies..."
cargo fetch

echo "Waiting for PostgreSQL to be ready..."
until pg_isready -h postgres -p 5432 -U postgres; do
  echo "Waiting for postgres..."
  sleep 2
done

echo "Running migrations for development database..."
sqlx migrate run --database-url postgresql://postgres:password@postgres:5432/alm

echo "Running migrations for test database..."
sqlx migrate run --database-url postgresql://postgres:password@postgres:5432/alm_test

echo "Building project..."
cargo build

echo "Post-create setup complete!"
