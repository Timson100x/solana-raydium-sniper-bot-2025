#!/bin/bash
set -e

echo "🚀 Setting up Solana Raydium Sniper Bot Development Environment..."

# Update system packages
echo "📦 Updating system packages..."
sudo apt-get update -qq

# Install required system dependencies
echo "📦 Installing system dependencies..."
sudo apt-get install -y -qq build-essential pkg-config libssl-dev libudev-dev

# Install Solana CLI
echo "⚙️  Installing Solana CLI..."
if ! command -v solana &> /dev/null; then
    sh -c "$(curl -sSfL https://release.solana.com/stable/install)"
    export PATH="/home/node/.local/share/solana/install/active_release/bin:$PATH"
    echo 'export PATH="/home/node/.local/share/solana/install/active_release/bin:$PATH"' >> ~/.bashrc
    solana --version
else
    echo "✅ Solana CLI already installed"
fi

# Verify Rust installation (should be installed via devcontainer feature)
echo "🦀 Verifying Rust installation..."
if command -v rustc &> /dev/null; then
    rustc --version
    cargo --version
else
    echo "⚠️  Rust not found, installing..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

# Install Node.js dependencies
echo "📦 Installing Node.js dependencies..."
npm install

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    if [ -f .env.example ]; then
        echo "📝 Creating .env file from .env.example..."
        cp .env.example .env
        echo "⚠️  Please configure your .env file with proper values"
    else
        echo "⚠️  No .env.example found. Please create .env manually"
    fi
fi

# Configure Solana for devnet (default for testing)
echo "🔧 Configuring Solana for devnet..."
solana config set --url https://api.devnet.solana.com

echo ""
echo "✅ Setup complete!"
echo ""
echo "📚 Next steps:"
echo "   1. Configure your .env file with your private key and RPC endpoints"
echo "   2. For testing on devnet: solana config set --url https://api.devnet.solana.com"
echo "   3. For mainnet: solana config set --url https://api.mainnet-beta.solana.com"
echo "   4. Run the bot: npm run start"
echo ""
echo "🔍 Useful commands:"
echo "   - Check Solana config: solana config get"
echo "   - Check wallet balance: solana balance <address>"
echo "   - View logs: npm run start"
echo ""
