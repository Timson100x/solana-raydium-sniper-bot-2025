# Use the official Microsoft devcontainer base image with Node.js
FROM mcr.microsoft.com/devcontainers/typescript-node:18-bullseye

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV SOLANA_VERSION=1.18.22

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    pkg-config \
    libudev-dev \
    llvm \
    libclang-dev \
    protobuf-compiler \
    libssl-dev \
    curl \
    wget \
    git \
    vim \
    jq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Switch to vscode user for installations
USER vscode

# Install Rust (already included via feature, but ensuring it's properly set up)
RUN if ! command -v rustc &> /dev/null; then \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable; \
    fi

# Add Rust to PATH
ENV PATH="/home/vscode/.cargo/bin:${PATH}"

# Install Solana CLI
RUN sh -c "$(curl -sSfL https://release.solana.com/v${SOLANA_VERSION}/install)" && \
    echo 'export PATH="/home/vscode/.local/share/solana/install/active_release/bin:$PATH"' >> /home/vscode/.bashrc

# Verify installations
RUN bash -c "source /home/vscode/.bashrc && \
    node --version && \
    npm --version && \
    rustc --version && \
    cargo --version"

# Set working directory
WORKDIR /workspace

# Switch back to root for any final setup
USER root

# Reset to non-interactive
ENV DEBIAN_FRONTEND=dialog

# Default back to vscode user
USER vscode
