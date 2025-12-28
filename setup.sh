#!/bin/bash

# Solana Raydium Sniper Bot - Development Environment Setup Script
# This script sets up the development environment for local development
# Supported: Linux, macOS, and Windows with WSL/Git Bash

set -e

echo "=================================================="
echo "Solana Raydium Sniper Bot - Dev Environment Setup"
echo "=================================================="
echo ""

# Check if we're on a supported platform
OS_TYPE=$(uname -s)
case "$OS_TYPE" in
    Linux*|Darwin*)
        echo "✅ Detected supported OS: $OS_TYPE"
        ;;
    MINGW*|MSYS*|CYGWIN*)
        echo "✅ Detected Windows with Unix tools: $OS_TYPE"
        ;;
    *)
        echo "❌ Unsupported operating system: $OS_TYPE"
        echo "This script is designed for Linux, macOS, or Windows with WSL/Git Bash"
        exit 1
        ;;
esac
echo ""

# Check Node.js
echo "Checking Node.js installation..."
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 20.x or later."
    exit 1
fi
NODE_VERSION=$(node --version)
echo "✅ Node.js $NODE_VERSION is installed"

# Check npm
echo "Checking npm installation..."
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed. Please install npm."
    exit 1
fi
NPM_VERSION=$(npm --version)
echo "✅ npm $NPM_VERSION is installed"

# Check Rust
echo "Checking Rust installation..."
if ! command -v rustc &> /dev/null; then
    echo "⚠️  Rust is not installed. Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    echo "✅ Rust installed successfully"
else
    RUST_VERSION=$(rustc --version)
    echo "✅ Rust $RUST_VERSION is installed"
fi

# Check Solana CLI
echo "Checking Solana CLI installation..."
if ! command -v solana &> /dev/null; then
    echo "⚠️  Solana CLI is not installed. Installing Solana CLI..."
    sh -c "$(curl -sSfL https://release.solana.com/stable/install)"
    export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
    echo "✅ Solana CLI installed successfully"
else
    SOLANA_VERSION=$(solana --version)
    echo "✅ Solana CLI $SOLANA_VERSION is installed"
fi

# Install npm dependencies
echo ""
echo "Installing npm dependencies..."
npm install
echo "✅ npm dependencies installed"

# Configure Solana for devnet (for testing)
echo ""
echo "Configuring Solana CLI for devnet..."
solana config set --url devnet
echo "✅ Solana configured for devnet"

# Check if .env file exists
echo ""
if [ ! -f .env ]; then
    echo "⚠️  .env file not found. Please create one based on .env.example"
    if [ -f .env.example ]; then
        echo "   You can copy .env.example to .env and update the values:"
        echo "   cp .env.example .env"
    fi
else
    echo "✅ .env file found"
fi

echo ""
echo "=================================================="
echo "✅ Development environment setup complete!"
echo "=================================================="
echo ""
echo "Next steps:"
echo "1. Update your .env file with your configuration"
echo "2. Run 'npm run start' to start the bot"
echo "3. For debugging, use 'npx ts-node start.ts'"
echo ""
echo "Useful commands:"
echo "  - solana --version          : Check Solana CLI version"
echo "  - solana config get         : View Solana configuration"
echo "  - solana balance            : Check wallet balance"
echo "  - npm run start             : Start the sniper bot"
echo ""
