# Solana Raydium Sniper Bot - Development Container

This directory contains the configuration for a GitHub Codespaces-compatible development environment for the Solana Raydium Sniper Bot 2025.

## What's Included

The development container includes:

### Tools and Runtimes
- **Node.js 18**: JavaScript runtime for running the bot
- **TypeScript**: Type-safe JavaScript development
- **Rust**: Required for Solana development and some native dependencies
- **Solana CLI**: Command-line tools for interacting with Solana blockchain
- **Git**: Version control

### VS Code Extensions
- **ESLint**: JavaScript/TypeScript linting
- **Prettier**: Code formatting
- **TypeScript**: Enhanced TypeScript support
- **Rust Analyzer**: Rust language support
- **LLDB**: Debugging support for Rust
- **Even Better TOML**: TOML file support
- **Crates**: Rust dependency management
- **Docker**: Container management

## Getting Started with Codespaces

### 1. Open in Codespaces
Click the "Code" button on the GitHub repository and select "Create codespace on main" (or your branch).

### 2. Wait for Container Build
The first time you open the codespace, it will:
- Build the Docker container with all required tools
- Install Rust and Solana CLI
- Install npm dependencies
- Configure Solana CLI for Devnet

This process takes 5-10 minutes on first launch.

### 3. Configure Environment Variables
Create a `.env` file in the root directory with your configuration:

```bash
# Copy the example configuration from README.md
PRIVATE_KEY=<your-wallet-private-key>
RPC_ENDPOINT=https://rpc.shyft.to?api_key=<your-api-key>
RPC_WEBSOCKET_ENDPOINT=wss://rpc.shyft.to?api_key=<your-api-key>
QUOTE_MINT=WSOL
QUOTE_AMOUNT=0.1
COMMITMENT_LEVEL=finalized
USE_SNIPE_LIST=false
SNIPE_LIST_REFRESH_INTERVAL=20000
CHECK_IF_MINT_IS_RENOUNCED=true
AUTO_SELL=true
MAX_SELL_RETRIES=5
AUTO_SELL_DELAY=30000
LOG_LEVEL=info
TAKE_PROFIT=50
STOP_LOSS=30
BIRDEYE_API_KEY=<your-birdeye-api-key>
MIN_POOL_SIZE=1
```

**Important**: Never commit your `.env` file to version control!

## Running the Bot

### Development Mode
```bash
npm run start
```

### Connecting to Solana Devnet

The Solana CLI is pre-configured for Devnet. You can verify with:
```bash
solana config get
```

To switch networks:
```bash
# Devnet (recommended for testing)
solana config set --url https://api.devnet.solana.com

# Mainnet-beta (for production - use with caution!)
solana config set --url https://api.mainnet-beta.solana.com

# Testnet
solana config set --url https://api.testnet.solana.com
```

### Creating a Test Wallet

For Devnet testing, you can create a new wallet:
```bash
# Generate a new keypair
solana-keygen new --outfile ~/devnet-wallet.json

# Get your wallet address
solana-keygen pubkey ~/devnet-wallet.json

# Request test SOL (airdrop)
solana airdrop 2 <YOUR_WALLET_ADDRESS> --url https://api.devnet.solana.com
```

### Getting RPC Endpoints

For better performance, get free RPC endpoints from:
- **Helius**: https://www.helius.dev/ (recommended)
- **QuickNode**: https://www.quicknode.com/
- **Shyft**: https://shyft.to/

### Getting Birdeye API Key

For TP/SL and Burn/Lock checks:
1. Visit: https://docs.birdeye.so/docs/authentication-api-keys
2. Sign up and generate a free API key
3. Add it to your `.env` file

## Wrapping SOL to WSOL

The bot typically uses WSOL (Wrapped SOL) for trading. To wrap SOL:

1. Use Jupiter: https://jup.ag/
2. Swap SOL → WSOL
3. The WSOL will appear in your wallet and can be used for trading

Recommended: Keep 0.9 SOL and 0.1 WSOL for testing (SOL is needed for transaction fees).

## Testing on Devnet

### Important Notes for Devnet Testing:
1. **Use Devnet tokens**: Regular mainnet tokens won't work on Devnet
2. **Devnet is slower**: Transactions may take longer than mainnet
3. **Test with small amounts**: Start with minimal amounts to verify functionality
4. **Monitor logs**: Use `LOG_LEVEL=debug` in `.env` for detailed output

### Devnet Testing Workflow:
```bash
# 1. Ensure you're on Devnet
solana config set --url https://api.devnet.solana.com

# 2. Check your balance
solana balance

# 3. Run the bot
npm run start
```

## Troubleshooting

### Solana CLI Not Found
If `solana` command is not found after container creation:
```bash
# Reload your shell
source ~/.bashrc

# Or restart the terminal
```

### Build Errors
If you encounter build errors:
```bash
# Clean install
rm -rf node_modules package-lock.json
npm install
```

### RPC Connection Issues
- Verify your RPC endpoints are correct in `.env`
- Check if your RPC provider has rate limits
- Try switching to a different RPC provider

### Transaction Failures
- Ensure you have enough SOL for gas fees
- Check if `COMMITMENT_LEVEL` is set to `finalized`
- Verify your RPC node supports all required methods

## Project Structure

```
.
├── .devcontainer/          # Development container configuration
│   ├── devcontainer.json   # Container specification
│   ├── Dockerfile          # Container image definition
│   ├── post-create.sh      # Post-creation setup script
│   └── README.md           # This file
├── constants/              # Bot constants
├── liquidity/              # Liquidity pool logic
├── market/                 # Market interaction logic
├── types/                  # TypeScript type definitions
├── utils/                  # Utility functions
├── start.ts               # Main entry point
├── package.json           # Node.js dependencies
├── tsconfig.json          # TypeScript configuration
└── .env                   # Environment variables (create this)
```

## Additional Resources

- **Solana Documentation**: https://docs.solana.com/
- **Raydium Documentation**: https://docs.raydium.io/
- **Solana Web3.js**: https://solana-labs.github.io/solana-web3.js/
- **SPL Token Guide**: https://spl.solana.com/token

## Security Best Practices

⚠️ **IMPORTANT SECURITY NOTES**:

1. **Never commit private keys**: Always keep `.env` in `.gitignore`
2. **Use separate wallets**: Don't use your main wallet for testing
3. **Start with Devnet**: Test thoroughly before using mainnet
4. **Limit bot funds**: Only keep necessary funds in the bot wallet
5. **Monitor activity**: Regularly check transactions and balances
6. **Secure RPC keys**: Treat RPC API keys as sensitive credentials
7. **Review code**: Understand what the bot does before running

## Support

For issues or questions:
- Check the main README.md in the repository root
- Review GitHub Issues
- Contact: Telegram @ZeeHolte

---

**Disclaimer**: This bot is provided for educational purposes. Use at your own risk. The developers are not responsible for any losses incurred while using this software.
