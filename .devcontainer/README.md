# GitHub Codespaces Development Environment

This repository is configured for seamless development using GitHub Codespaces. The devcontainer configuration automatically sets up all necessary tools and dependencies for developing and testing the Solana Raydium Sniper Bot.

## What's Included

The Codespaces environment comes pre-configured with:

### Core Tools
- **Node.js 20.x** - JavaScript runtime
- **TypeScript** - Latest version with full tooling support
- **Rust** - Latest stable toolchain with default profile
- **Solana CLI** - Latest stable version for blockchain interaction

### Development Tools
- **VS Code Extensions:**
  - TypeScript and ESLint support
  - Rust Analyzer for Rust development
  - Prettier for code formatting
  - Solana code snippets
  - TOML support for configuration files
  - Error Lens for inline error display

### Configuration
- Solana CLI pre-configured to use **Devnet** by default
- Automatic npm dependency installation
- Port forwarding for local Solana validator (8899, 8900)

## Getting Started with Codespaces

### 1. Launch Codespaces

Click the "Code" button on the GitHub repository page and select "Create codespace on main" (or your desired branch).

The environment will automatically:
- Build the development container
- Install Solana CLI
- Install Node.js dependencies
- Configure Solana for Devnet

This process takes approximately 3-5 minutes on the first launch.

### 2. Configure Your Environment

After the Codespace launches, configure your bot settings:

```bash
# The .env file is already present, edit it with your settings
# Update the following values:
# - PRIVATE_KEY (your Solana wallet private key)
# - RPC_ENDPOINT (your RPC node URL)
# - RPC_WEBSOCKET_ENDPOINT (your WebSocket RPC URL)
# - Other bot configuration parameters
```

**For testing on Devnet:**
```bash
# Use public Devnet endpoints (free, rate-limited)
RPC_ENDPOINT=https://api.devnet.solana.com
RPC_WEBSOCKET_ENDPOINT=wss://api.devnet.solana.com
```

### 3. Solana Wallet Setup

#### Option A: Use Existing Wallet
If you have an existing Solana wallet, add your private key to the `.env` file:
```
PRIVATE_KEY=your_base58_encoded_private_key
```

#### Option B: Create New Wallet
```bash
# Generate a new wallet
solana-keygen new --outfile ~/my-wallet.json

# Get your wallet address
solana-keygen pubkey ~/my-wallet.json

# Export private key (needed for .env)
# Note: Keep this secure and never commit to git!
cat ~/my-wallet.json
```

#### Get Test SOL (Devnet Only)
```bash
# Request airdrop on Devnet
solana airdrop 2

# Check balance
solana balance
```

### 4. Running the Bot

```bash
# Start the sniper bot
npm run start
```

The bot will:
- Connect to the configured RPC endpoint
- Listen for new Raydium liquidity pools
- Execute trades based on your configuration in `.env`

### 5. Development Workflow

#### Check Solana Configuration
```bash
solana config get
```

#### Switch Networks
```bash
# Switch to Devnet
solana config set --url https://api.devnet.solana.com

# Switch to Mainnet (use with caution!)
solana config set --url https://api.mainnet-beta.solana.com
```

#### View Logs
The bot uses Pino logger with pretty printing. Logs appear in the console where you run `npm run start`.

#### Code Editing
- TypeScript files are automatically type-checked
- Prettier formats code on save
- ESLint provides real-time feedback

## Useful Solana CLI Commands

```bash
# Check Solana version
solana --version

# Check current configuration
solana config get

# Check wallet balance
solana balance

# View recent transactions
solana transaction-history

# Get cluster info
solana cluster-version

# Request airdrop (Devnet/Testnet only)
solana airdrop 1

# Transfer SOL
solana transfer <RECIPIENT_ADDRESS> <AMOUNT>
```

## RPC Endpoints

### Devnet (Testing)
- **HTTP:** `https://api.devnet.solana.com`
- **WebSocket:** `wss://api.devnet.solana.com`

### Mainnet-Beta (Production)
For production use, consider using a dedicated RPC provider:
- [Helius](https://www.helius.dev/) - Free tier available
- [QuickNode](https://www.quicknode.com/) - Free tier available
- [Shyft](https://shyft.to/) - Free tier available

Update your `.env` file with your provider's endpoints.

## Troubleshooting

### Solana CLI Not Found
```bash
# Check if Solana is in PATH
echo $PATH | grep solana

# If not, reload the shell
source ~/.bashrc

# Or manually add to PATH
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
```

### Dependencies Not Installed
```bash
# Manually install dependencies
npm install
```

### RPC Connection Issues
- Verify your RPC_ENDPOINT in `.env`
- Check if you're hitting rate limits
- Try switching to a different RPC provider
- For testing, use Devnet endpoints

### TypeScript Errors
```bash
# Check TypeScript compilation
npx tsc --noEmit

# Clear cache and reinstall
rm -rf node_modules package-lock.json
npm install
```

## Security Best Practices

⚠️ **Important Security Notes:**

1. **Never commit private keys** to version control
2. **Use .env file** for sensitive configuration (it's in .gitignore)
3. **Test on Devnet first** before using real funds
4. **Use dedicated wallets** for bot operations
5. **Regularly rotate API keys** and access tokens
6. **Monitor bot activity** and set appropriate limits

## Additional Resources

- [Solana Documentation](https://docs.solana.com/)
- [Raydium Documentation](https://docs.raydium.io/)
- [Solana CLI Guide](https://docs.solana.com/cli)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)

## Support

For issues specific to this repository, please create an issue on GitHub.
For Solana-related questions, visit the [Solana Stack Exchange](https://solana.stackexchange.com/).

## License

See the LICENSE file in the repository root.
