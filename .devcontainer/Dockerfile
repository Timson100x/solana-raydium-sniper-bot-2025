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

# Add Rust to PATH (Rust is installed via devcontainer feature)
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
