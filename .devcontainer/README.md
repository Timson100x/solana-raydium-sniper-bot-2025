# GitHub Codespaces Development Environment

This directory contains the configuration for GitHub Codespaces, enabling you to develop and test the Solana Raydium Sniper Bot directly in your browser with all necessary tools pre-installed.

## What's Included

### Development Tools
- **Node.js 20**: JavaScript runtime for running the bot
- **TypeScript**: Type-safe JavaScript development
- **Rust**: Required for Solana program development and tools
- **Solana CLI**: Command-line tools for interacting with Solana blockchain
- **Git**: Version control

### Pre-installed VS Code Extensions
- **ESLint**: JavaScript/TypeScript linting
- **Prettier**: Code formatting
- **TypeScript**: Enhanced TypeScript support
- **Rust Analyzer**: Intelligent Rust language support
- **LLDB Debugger**: Debugging support for Rust
- **Even Better TOML**: TOML file support for Rust projects
- **Crates**: Rust dependency management
- **GitHub Copilot**: AI-powered code completion (if you have access)

## Getting Started

### 1. Open in Codespaces

Click the "Code" button on the repository page and select "Create codespace on main" (or your preferred branch).

GitHub will automatically:
- Create a containerized development environment
- Install all required tools (Node.js, Rust, Solana CLI)
- Install npm dependencies
- Configure Solana CLI to use devnet by default

### 2. Configure Your Environment

After the codespace is created, you need to configure your bot:

```bash
# 1. Copy the example environment file (if not already done)
cp .env.example .env

# 2. Edit the .env file with your configuration
# Add your wallet private key, RPC endpoints, and other settings
nano .env  # or use the VS Code editor
```

### 3. Verify Installation

Check that all tools are properly installed:

```bash
# Check Node.js version
node --version

# Check npm version
npm --version

# Check TypeScript version
npx tsc --version

# Check Rust version
rustc --version

# Check Solana CLI version
solana --version

# Check Solana configuration
solana config get
```

### 4. Run the Bot

```bash
# Start the bot
npm run start
```

## Solana CLI Quick Reference

### Configuration Management
```bash
# View current configuration
solana config get

# Set RPC URL to devnet (default)
solana config set --url https://api.devnet.solana.com

# Set RPC URL to mainnet-beta (for production)
solana config set --url https://api.mainnet-beta.solana.com

# Set RPC URL to testnet
solana config set --url https://api.testnet.solana.com
```

### Wallet Management
```bash
# Check wallet balance
solana balance

# Get wallet address
solana address

# Airdrop SOL (devnet/testnet only)
solana airdrop 2
```

### Network Information
```bash
# Check cluster version
solana cluster-version

# Get recent block production
solana block-production

# Check transaction status
solana confirm <SIGNATURE>
```

## Development Workflow

### 1. Development with Devnet

Start by testing on devnet (configured by default):

```bash
# Ensure you're on devnet
solana config set --url https://api.devnet.solana.com

# Get some devnet SOL
solana airdrop 2

# Run the bot
npm run start
```

### 2. TypeScript Development

```bash
# Check for TypeScript errors without emitting files
npx tsc --noEmit

# Watch mode for continuous compilation checking
npx tsc --noEmit --watch
```

### 3. Code Formatting

```bash
# Format all code files
npx prettier --write .

# Check formatting without making changes
npx prettier --check .
```

### 4. Testing Before Production

Before running on mainnet:
1. Test thoroughly on devnet
2. Verify all configurations in `.env`
3. Ensure you have sufficient SOL for transaction fees
4. Set up proper monitoring and alerts

## Troubleshooting

### Issue: Solana CLI not found
```bash
# Ensure Solana is in PATH
export PATH="/home/node/.local/share/solana/install/active_release/bin:$PATH"

# Or restart the terminal
```

### Issue: npm install fails
```bash
# Clear npm cache and reinstall
npm cache clean --force
rm -rf node_modules package-lock.json
npm install
```

### Issue: TypeScript errors
```bash
# Ensure TypeScript is installed
npm install --save-dev typescript

# Check tsconfig.json is present
ls -la tsconfig.json
```

### Issue: RPC Connection errors
- Ensure your RPC_ENDPOINT and RPC_WEBSOCKET_ENDPOINT in `.env` are correct
- Consider using Helius or QuickNode for reliable RPC access
- Check your network connectivity

## Important Security Notes

⚠️ **Never commit your `.env` file or private keys to version control!**

- The `.env` file contains sensitive information
- Keep your private keys secure
- Use environment variables for sensitive data
- Consider using a separate wallet for testing on devnet

## Additional Resources

- [Solana CLI Documentation](https://docs.solana.com/cli)
- [Solana Developer Documentation](https://docs.solana.com/)
- [Raydium SDK Documentation](https://raydium.gitbook.io/raydium/)
- [GitHub Codespaces Documentation](https://docs.github.com/en/codespaces)

## Customizing the Environment

If you need to customize the development environment:

1. Edit `.devcontainer/devcontainer.json` to add more VS Code extensions or change settings
2. Modify `.devcontainer/post-create.sh` to add custom setup steps
3. Commit and push your changes
4. Rebuild the codespace: `Cmd/Ctrl + Shift + P` → "Codespaces: Rebuild Container"

## Support

For issues specific to this bot, please refer to the main [README.md](../README.md) or contact via Telegram: @ZeeHolte
