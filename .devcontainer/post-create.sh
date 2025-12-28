#!/bin/bash -e

# Post-create script for Solana Raydium Sniper Bot development environment
echo "🚀 Setting up Solana Raydium Sniper Bot development environment..."

# Ensure Solana CLI is in PATH
export PATH="/home/vscode/.local/share/solana/install/active_release/bin:$PATH"

# Verify Solana installation
if command -v solana &> /dev/null; then
    echo "✅ Solana CLI version: $(solana --version)"
    
    # Configure Solana CLI for devnet by default
    solana config set --url https://api.devnet.solana.com
    echo "✅ Solana CLI configured for Devnet"
else
    echo "⚠️  Solana CLI not found in PATH. You may need to restart the terminal."
fi

# Install npm dependencies
echo "📦 Installing npm dependencies..."
npm install

# Verify installations
echo ""
echo "🔍 Verifying installations..."
echo "Node.js: $(node --version)"
echo "npm: $(npm --version)"
echo "TypeScript: $(npx tsc --version)"
echo "Rust: $(rustc --version 2>/dev/null || echo 'Not found')"
echo "Cargo: $(cargo --version 2>/dev/null || echo 'Not found')"

# Check if .env file exists, if not, suggest creating one
if [ ! -f .env ]; then
    echo ""
    echo "⚠️  .env file not found!"
    echo "📝 Please create a .env file based on the configuration in README.md"
    echo "   You can copy the example configuration and update it with your credentials:"
    echo ""
    echo "   Required variables:"
    echo "   - PRIVATE_KEY (your Solana wallet private key)"
    echo "   - RPC_ENDPOINT (HTTPS RPC endpoint)"
    echo "   - RPC_WEBSOCKET_ENDPOINT (WebSocket RPC endpoint)"
    echo "   - QUOTE_MINT (USDC or WSOL)"
    echo "   - QUOTE_AMOUNT (amount to buy with)"
    echo "   - BIRDEYE_API_KEY (for TP/SL, Burn/Lock checks)"
    echo ""
fi

# Create a sample wallet for testing (optional)
echo ""
echo "💡 Tip: You can create a new Solana wallet for testing with:"
echo "   solana-keygen new --outfile ~/devnet-wallet.json"
echo ""
echo "💡 To get test SOL for Devnet:"
echo "   solana airdrop 2 <YOUR_WALLET_ADDRESS> --url https://api.devnet.solana.com"
echo ""

echo "✅ Development environment setup complete!"
echo ""
echo "📚 Quick Start:"
echo "   1. Configure your .env file with your wallet and RPC details"
echo "   2. Run 'npm run start' to start the sniper bot"
echo "   3. Check README.md for detailed configuration options"
echo ""
