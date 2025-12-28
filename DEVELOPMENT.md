# Development Guide for Solana Raydium Sniper Bot

## Development Environment Setup

This guide provides comprehensive instructions for setting up and using the development environment for the Solana Raydium Sniper Bot in GitHub Codespaces or locally.

## Prerequisites

- **Node.js**: v20.x or later
- **npm**: v10.x or later
- **Rust**: Latest stable version (for Solana development)
- **Solana CLI**: Latest stable version
- **Git**: For version control

## Quick Setup

### Using GitHub Codespaces

1. Open the repository in GitHub Codespaces
2. The environment will automatically set up with all required dependencies
3. Wait for the postCreateCommand to complete (`npm install`)
4. Configure your `.env` file with your settings
5. Run `npm run start` to begin

### Local Development Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/Timson100x/solana-raydium-sniper-bot-2025.git
   cd solana-raydium-sniper-bot-2025
   ```

2. Run the setup script:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

3. Or manually install dependencies:
   ```bash
   # Install Rust
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   
   # Install Solana CLI
   sh -c "$(curl -sSfL https://release.solana.com/stable/install)"
   
   # Install npm dependencies
   npm install
   ```

## Environment Configuration

1. Copy the example environment file:
   ```bash
   cp .env.example .env
   ```

2. Update `.env` with your configuration:
   ```
   PRIVATE_KEY=<your-wallet-private-key>
   RPC_ENDPOINT=<your-rpc-endpoint>
   RPC_WEBSOCKET_ENDPOINT=<your-websocket-endpoint>
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

## Development Commands

### Running the Bot

```bash
# Start the bot (production mode)
npm run start

# Start with ts-node for development
npx ts-node start.ts
```

### TypeScript Development

```bash
# Check TypeScript compilation without emitting files
npx tsc --noEmit

# Watch mode for TypeScript compilation
npx tsc --watch

# Compile TypeScript to JavaScript
npx tsc
```

### Code Quality

```bash
# Format code with Prettier
npx prettier --write "**/*.ts"

# Check formatting
npx prettier --check "**/*.ts"
```

## Solana CLI Commands

### Configuration

```bash
# View current Solana configuration
solana config get

# Set network to devnet (for testing)
solana config set --url devnet

# Set network to mainnet
solana config set --url mainnet-beta

# Set custom RPC
solana config set --url <your-rpc-url>
```

### Wallet Management

```bash
# Check wallet balance
solana balance <wallet-address>

# Airdrop SOL on devnet (for testing)
solana airdrop 2 <wallet-address>

# Check token accounts
spl-token accounts
```

## Testing on Devnet

For safe testing without risking real funds:

1. Configure Solana CLI for devnet:
   ```bash
   solana config set --url devnet
   ```

2. Update your `.env` file:
   ```
   RPC_ENDPOINT=https://api.devnet.solana.com
   RPC_WEBSOCKET_ENDPOINT=wss://api.devnet.solana.com
   ```

3. Get devnet SOL:
   ```bash
   solana airdrop 2
   ```

4. Test the bot with minimal amounts

## Debugging

### VSCode Debug Configuration

Create `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Debug Bot",
      "runtimeArgs": ["-r", "ts-node/register"],
      "args": ["${workspaceFolder}/start.ts"],
      "env": {
        "NODE_ENV": "development"
      },
      "console": "integratedTerminal",
      "internalConsoleOptions": "neverOpen"
    }
  ]
}
```

### Logging

- Logs are output to console using `pino-pretty`
- Error logs can be found in `buy.log` (if enabled in start.ts)
- Adjust log level in `.env`: `LOG_LEVEL=trace|debug|info|warn|error`

### Common Issues

1. **"No SOL token account found"**: Swap some SOL to WSOL/USDC on Jupiter
2. **RPC errors**: Use a reliable RPC provider (Helius, QuickNode, Shyft)
3. **Transaction failures**: Increase compute budget or adjust commitment level
4. **Empty transactions**: Change commitment level to `finalized`

## Project Structure

```
.
├── .devcontainer/          # GitHub Codespaces configuration
│   ├── devcontainer.json   # Codespaces settings
│   └── Dockerfile          # Development container
├── constants/              # Configuration constants
├── liquidity/              # Liquidity pool handlers
├── market/                 # Market data handlers
├── types/                  # TypeScript type definitions
├── utils/                  # Utility functions
├── start.ts                # Main entry point
├── package.json            # Node.js dependencies
├── tsconfig.json           # TypeScript configuration
├── setup.sh                # Setup script
└── .env                    # Environment variables (create from .env.example)
```

## Key Files

- **start.ts**: Main bot logic, event listeners, buy/sell functions
- **liquidity/liquidity.ts**: Raydium liquidity pool interactions
- **market/market.ts**: OpenBook market data handling
- **utils/utils.ts**: Helper functions for token prices and retries
- **types/mint.ts**: Mint account layout and types

## Development Workflow

1. Make changes to TypeScript files
2. Test compilation: `npx tsc --noEmit`
3. Run the bot: `npm run start`
4. Monitor logs for errors
5. Debug using VSCode or console logs
6. Commit changes to Git

## Security Notes

- **Never commit your `.env` file** with real private keys
- **Never share your private key** with anyone
- **Use devnet for testing** before running on mainnet
- **Start with small amounts** when testing on mainnet
- **Monitor your wallet** when the bot is running

## Performance Optimization

1. **RPC Node**: Use a fast, reliable RPC node (Helius, QuickNode)
2. **Network**: Ensure low latency to RPC endpoint
3. **Compute Budget**: Adjust compute units for faster transactions
4. **Commitment Level**: Use `confirmed` for speed, `finalized` for safety

## Additional Resources

- [Solana Documentation](https://docs.solana.com/)
- [Raydium SDK](https://github.com/raydium-io/raydium-sdk)
- [OpenBook (Serum) DEX](https://github.com/openbook-dex)
- [TypeScript Documentation](https://www.typescriptlang.org/)

## Support

For issues and questions:
- Check README.md for common issues
- Review code comments in source files
- Contact: Telegram @ZeeHolte

## License

See LICENSE file for details.
