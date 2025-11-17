FROM mcr.microsoft.com/devcontainers/rust:1-bullseye

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        postgresql-client \
        libpq-dev \
        pkg-config \
        libssl-dev \
        build-essential \
        curl \
        git \
        vim \
        less \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN rustup component add rustfmt clippy rust-src

RUN cargo install cargo-watch \
    && cargo install sqlx-cli --no-default-features --features rustls,postgres

RUN if [ "$USER_GID" != "1000" ] || [ "$USER_UID" != "1000" ]; then \
        groupmod --gid $USER_GID $USERNAME \
        && usermod --uid $USER_UID --gid $USER_GID $USERNAME \
        && chown -R $USER_UID:$USER_GID /home/$USERNAME; \
    fi

RUN chown -R $USERNAME:$USERNAME /usr/local/cargo /usr/local/rustup

USER $USERNAME

ENV CARGO_HOME=/usr/local/cargo
ENV RUSTUP_HOME=/usr/local/rustup
ENV PATH=${CARGO_HOME}/bin:${PATH}

WORKDIR /workspace
