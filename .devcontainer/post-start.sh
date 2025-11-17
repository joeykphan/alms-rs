#!/bin/bash
set -e

echo "Running post-start commands..."

echo "Checking database connection..."
pg_isready -h postgres -p 5432 -U postgres || echo "Warning: PostgreSQL not ready"

echo "Ready to develop!"
