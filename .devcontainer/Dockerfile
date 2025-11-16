FROM mcr.microsoft.com/devcontainers/rust:1

# Install system packages required for Postgres/Diesel builds
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libpq-dev \
    pkg-config \
    libssl-dev \
    ca-certificates \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install diesel_cli for migrations (Postgres feature)
RUN cargo install diesel_cli --no-default-features --features postgres || true

USER vscode
