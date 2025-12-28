# Use Node.js LTS as base image
FROM node:20-bullseye

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    pkg-config \
    libudev-dev \
    libssl-dev \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Install Solana CLI
RUN sh -c "$(curl -sSfL https://release.solana.com/stable/install)" && \
    echo 'export PATH="/root/.local/share/solana/install/active_release/bin:$PATH"' >> ~/.bashrc
ENV PATH="/root/.local/share/solana/install/active_release/bin:${PATH}"

# Set working directory
WORKDIR /workspace

# Copy package files
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Set Solana to devnet by default for testing
RUN solana config set --url devnet || true

# Expose any necessary ports (none needed for this bot by default)
# EXPOSE 3000

# Default command
CMD ["bash"]
