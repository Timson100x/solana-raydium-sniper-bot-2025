#!/bin/bash
set -e

echo "🚀 Setting up Solana Raydium Sniper Bot Development Environment..."

# Install Solana CLI
echo "📦 Installing Solana CLI..."
sh -c "$(curl -sSfL https://release.solana.com/stable/install)"

# Add Solana to PATH for current session
export PATH="/home/node/.local/share/solana/install/active_release/bin:$PATH"

# Verify Solana installation
echo "✅ Verifying Solana CLI installation..."
solana --version

# Set Solana to devnet by default
echo "🌐 Configuring Solana CLI to use devnet..."
solana config set --url https://api.devnet.solana.com

# Install npm dependencies
echo "📦 Installing npm dependencies..."
npm install

# Create .env file from example if it doesn't exist
if [ ! -f .env ] && [ -f .env.example ]; then
    echo "📝 Creating .env file from .env.example..."
    cp .env.example .env
    echo "⚠️  Remember to update .env with your configuration!"
fi

# Display helpful information
echo ""
echo "✨ Development environment setup complete!"
echo ""
echo "📚 Quick Start Guide:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "1️⃣  Configure your environment:"
echo "   - Edit .env file with your settings"
echo "   - Add your PRIVATE_KEY and RPC endpoints"
echo ""
echo "2️⃣  Run the bot:"
echo "   npm run start"
echo ""
echo "3️⃣  Solana CLI commands:"
echo "   - Check config: solana config get"
echo "   - Check balance: solana balance"
echo "   - Switch to mainnet: solana config set --url https://api.mainnet-beta.solana.com"
echo "   - Switch to devnet: solana config set --url https://api.devnet.solana.com"
echo ""
echo "4️⃣  Useful development commands:"
echo "   - TypeScript compilation check: npx tsc --noEmit"
echo "   - Format code: npx prettier --write ."
echo ""
echo "📖 For more information, check the README.md file"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Run environment validation
echo "🔍 Running environment validation..."
echo ""
bash .devcontainer/validate-environment.sh || true
echo ""
