
# Development Container Setup

This project includes a complete VS Code DevContainer configuration for Rust development.

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## Getting Started

### 1. Clone the Repository
```bash
git clone <repository-url>
cd finance-backend
```

### 2. Set Up Environment Variables

Create a `.env` file in the project root:
```bash
cp .env.example .env
```

Edit `.env` and add your Plaid API credentials (get free sandbox credentials at https://dashboard.plaid.com/signup).

### 3. Open in DevContainer

**Option A: Using VS Code Command Palette**
1. Open the project folder in VS Code
2. Press `F1` or `Ctrl+Shift+P` (Cmd+Shift+P on Mac)
3. Type "Dev Containers: Reopen in Container"
4. Select it and wait for the container to build

**Option B: Using VS Code Prompt**
1. Open the project folder in VS Code
2. VS Code will detect the `.devcontainer` folder
3. Click "Reopen in Container" when prompted

### 4. Wait for Setup

The container will:
- Build the Rust development environment
- Start PostgreSQL
- Create development and test databases
- Run database migrations
- Build the project

This takes 3-5 minutes on first run.

## What's Included

### Development Tools
- **Rust** (latest stable with rustfmt, clippy, rust-src)
- **cargo-watch** - Auto-reload on file changes
- **sqlx-cli** - Database migration tool
- **PostgreSQL 15** - Development and test databases

### VS Code Extensions
- rust-analyzer - Rust language server
- CodeLLDB - Debugging support
- Crates - Cargo.toml dependency management
- Even Better TOML - TOML file support
- Docker - Container management
- SQLTools - Database management
- GitHub Copilot (if you have it)
- GitLens - Git integration

### Database Configuration
- **Dev DB**: `financeapp` on `postgres:5432`
- **Test DB**: `financeapp_test` on `postgres:5432`
- **User**: `postgres`
- **Password**: `password`

## Available Commands

### Using Make
```bash
make dev          # Run dev server with auto-reload
make test         # Run all tests
make test-verbose # Run tests with output
make lint         # Run clippy
make fmt          # Format code
make migrate-up   # Run migrations
make migrate-down # Rollback migration
make db-reset     # Reset both databases
```

### Using Cargo
```bash
cargo run                 # Start the server
cargo test               # Run tests
cargo watch -x run       # Auto-reload dev server
cargo clippy             # Lint code
cargo fmt                # Format code
sqlx migrate run         # Run migrations
```

### Using VS Code Tasks
Press `Ctrl+Shift+B` (Cmd+Shift+B on Mac) to see available tasks:
- Build and run the project
- Run tests
- Watch for changes
- Run migrations

## Debugging

### Debug the Application
1. Set breakpoints in your code
2. Press `F5` or go to Run > Start Debugging
3. Select "Debug executable 'finance-backend'"

### Debug Tests
1. Set breakpoints in test code
2. Press `F5`
3. Select "Debug unit tests"

## Database Management

### Using SQLTools Extension
1. Click the SQLTools icon in the sidebar
2. Select "PostgreSQL - Dev" or "PostgreSQL - Test"
3. Click "Connect"
4. Browse tables, run queries

### Using psql
```bash
# Connect to dev database
psql postgresql://postgres:password@postgres:5432/financeapp

# Connect to test database
psql postgresql://postgres:password@postgres:5432/financeapp_test
```

## Running Tests

Tests use a separate test database to avoid conflicts with development data.

```bash
# Run all tests
make test

# Run specific test
cargo test test_create_account

# Run with output
make test-verbose

# Run integration tests only
cargo test --test '*'
```

## Common Tasks

### Add a New Migration
```bash
sqlx migrate add <migration_name>
# Edit the new file in migrations/
make migrate-up
```

### Reset Databases
```bash
make db-reset
```

### Check Code Quality
```bash
make lint
make fmt
```

### View Logs
```bash
# Application logs
cargo run

# Container logs
docker-compose logs -f
```

## Port Forwarding

The following ports are automatically forwarded:
- **8000** - Backend API
- **5432** - PostgreSQL

Access the API at: http://localhost:8000

## Troubleshooting

### Container Won't Start
```bash
# Rebuild container
docker-compose down
docker-compose build --no-cache
```

### Database Connection Issues
```bash
# Check postgres is running
docker ps

# Restart postgres
docker-compose restart postgres

# Check logs
docker-compose logs postgres
```

### Permission Issues
```bash
# Fix ownership
sudo chown -R $USER:$USER .
```

### Clean Start
```bash
# Stop everything
docker-compose down -v

# Remove all containers and volumes
docker system prune -a --volumes

# Reopen in container
```

## Tips

1. **Use cargo-watch for development**
   ```bash
   cargo watch -x run
   ```

2. **Run tests before committing**
   ```bash
   make test && make lint
   ```

3. **Use SQLTools for database inspection**
   - Click the database icon in the sidebar
   - Browse tables and run queries visually

4. **Set breakpoints and debug**
   - Press F9 to set breakpoints
   - Press F5 to start debugging

5. **Format on save is enabled**
   - Code automatically formats when you save

## Environment Variables

Set these in your `.env` file:
- `DATABASE_URL` - Dev database connection
- `DATABASE_TEST_URL` - Test database connection
- `JWT_SECRET` - Secret for JWT tokens
- `PLAID_CLIENT_ID` - Plaid API client ID
- `PLAID_SECRET` - Plaid API secret
- `PLAID_ENV` - Plaid environment (sandbox/development/production)
- `RUST_LOG` - Logging level (info, debug, trace)

## Next Steps

1. Start the development server: `make dev`
2. Open http://localhost:8000/health to verify it's running
3. Check out the API documentation in the main README.md
4. Start building features!

## Getting Help

- Check the main README.md for API documentation
- View logs: `docker-compose logs -f`
- Inspect database: Use SQLTools extension
- Debug: Press F5 in VS Code

Happy coding! 🚀
