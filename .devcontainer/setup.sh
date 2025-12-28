#!/bin/bash

set -e

echo "================================"
echo "Solana Raydium Sniper Bot Setup"
echo "================================"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Install Solana CLI
# Using official Solana installation script from https://docs.solana.com/cli/install-solana-cli-tools
# The stable release channel provides a tested and verified version
echo -e "${YELLOW}Installing Solana CLI...${NC}"
sh -c "$(curl -sSfL https://release.solana.com/stable/install)"

# Add Solana to PATH for this session (script execution)
# Note: PATH is also configured in devcontainer.json for all future terminal sessions
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"

# Verify Solana installation
echo -e "${GREEN}Solana CLI installed successfully!${NC}"
solana --version

# Configure Solana to use Devnet by default
echo -e "${YELLOW}Configuring Solana CLI for Devnet...${NC}"
solana config set --url https://api.devnet.solana.com

# Install npm dependencies
echo -e "${YELLOW}Installing Node.js dependencies...${NC}"
npm install

echo ""
echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}Setup Complete!${NC}"
echo -e "${GREEN}================================${NC}"
echo ""
echo "Getting Started:"
echo "1. Configure your bot settings in the .env file:"
echo "   Edit .env and update PRIVATE_KEY, RPC_ENDPOINT, and other settings"
echo ""
echo "2. To run the bot:"
echo "   npm run start"
echo ""
echo "3. Solana CLI Commands:"
echo "   - Check Solana version: solana --version"
echo "   - Check config: solana config get"
echo "   - Create a new wallet: solana-keygen new"
echo "   - Check wallet balance: solana balance"
echo "   - Airdrop SOL (Devnet only): solana airdrop 2"
echo ""
echo "4. Current Solana configuration:"
solana config get
echo ""
echo -e "${YELLOW}Important: Update .env with your wallet private key and RPC endpoints${NC}"
echo -e "${YELLOW}For testing, use Devnet: https://api.devnet.solana.com${NC}"
echo ""
