# 🚀 GitHub Codespaces Quick Start Guide

Get started with the Solana Raydium Sniper Bot in minutes using GitHub Codespaces!

## What is GitHub Codespaces?

GitHub Codespaces provides a complete, cloud-based development environment. You can develop, build, and test the bot directly in your browser without installing anything on your local machine.

## Quick Setup (5 Minutes)

### Step 1: Create Your Codespace

1. Go to the repository on GitHub
2. Click the green **"Code"** button
3. Select the **"Codespaces"** tab
4. Click **"Create codespace on main"** (or your preferred branch)

GitHub will now create your development environment. This takes about 2-3 minutes.

### Step 2: Wait for Automatic Setup

The environment will automatically:
- ✅ Install Node.js 20
- ✅ Install Rust and Cargo
- ✅ Install Solana CLI
- ✅ Configure Solana for devnet
- ✅ Install all npm dependencies
- ✅ Copy `.env.example` to `.env`

Watch the terminal at the bottom of the screen for progress.

### Step 3: Configure Your Bot

After setup completes, configure your bot:

```bash
# Open the .env file in VS Code
# Click on .env in the file explorer or run:
code .env
```

**Required Configuration:**
- `PRIVATE_KEY`: Your Solana wallet private key (base58 encoded)
- `RPC_ENDPOINT`: Your RPC endpoint URL
- `RPC_WEBSOCKET_ENDPOINT`: Your WebSocket RPC endpoint URL
- `BIRDEYE_API_KEY`: Your Birdeye API key (get free at https://docs.birdeye.so/)

**Optional Configuration:**
- `QUOTE_MINT`: WSOL or USDC (default: WSOL)
- `QUOTE_AMOUNT`: Amount to spend per trade (default: 0.1)
- `TAKE_PROFIT`: Profit percentage target (default: 50)
- `STOP_LOSS`: Loss percentage limit (default: 30)

### Step 4: Test on Devnet First

Before using real funds, test on Solana devnet:

```bash
# Verify Solana CLI is configured for devnet
solana config get

# Should show: RPC URL: https://api.devnet.solana.com

# Get your wallet address
solana address

# Get free devnet SOL for testing
solana airdrop 2

# Check your balance
solana balance
```

### Step 5: Run the Bot

```bash
# Start the bot
npm run start
```

Watch the console output for connection status and trading activity.

## Development Tips

### Testing Your Changes

```bash
# Check for TypeScript errors
npx tsc --noEmit

# Format your code
npx prettier --write .
```

### Switching Networks

```bash
# Use devnet (recommended for testing)
solana config set --url https://api.devnet.solana.com

# Use mainnet-beta (for production)
solana config set --url https://api.mainnet-beta.solana.com
```

### Checking Logs

The bot logs important information to the console. You can adjust log level in `.env`:

```bash
# Options: trace, debug, info, warn, error
LOG_LEVEL=info
```

## Important Security Tips

⚠️ **NEVER share your private key or commit it to git!**

- The `.env` file is already in `.gitignore`
- Use a separate wallet for testing on devnet
- Keep minimal funds in your mainnet trading wallet
- Regularly review your `.env` file to ensure no sensitive data

## Troubleshooting

### Problem: "Solana command not found"

```bash
# Add Solana to PATH
export PATH="/home/node/.local/share/solana/install/active_release/bin:$PATH"

# Or reload your terminal
exit  # Then reopen terminal
```

### Problem: "npm install fails"

```bash
# Clear cache and reinstall
npm cache clean --force
rm -rf node_modules
npm install
```

### Problem: "RPC connection error"

- Check your RPC endpoints in `.env`
- Ensure you're using a valid RPC provider (Helius, QuickNode, etc.)
- Try switching to a different RPC endpoint

### Problem: "Transaction fails immediately"

- Ensure you have sufficient SOL for transaction fees
- Check that you have WSOL or USDC as configured in `QUOTE_MINT`
- Verify your wallet has the required tokens

## Getting RPC Endpoints

For best performance, get RPC endpoints from reliable providers:

### Recommended Providers

> **Note**: Rate limits and pricing information below is current as of December 2024. 
> Always verify current limits and pricing directly with the provider as they may change.

| Provider | Free Tier | Rate Limits | Best For | Notes |
|----------|-----------|-------------|----------|-------|
| **Helius** | 100 req/sec | Generous limits | General use, testing | Recommended - Great free tier |
| **QuickNode** | 15M credits/month | Varies by plan | Production use | Reliable, good performance |
| **Alchemy** | 300M compute units | Daily limits | Development | Good for testing |

**Getting Started:**
1. Sign up for a free account at your chosen provider
2. Create a new Solana project/app
3. Copy the HTTP and WebSocket RPC URLs
4. Add them to your `.env` file as `RPC_ENDPOINT` and `RPC_WEBSOCKET_ENDPOINT`

**Tip:** Start with Helius for development, then consider upgrading to a paid tier for production trading.

## Next Steps

1. ✅ Test on devnet with small amounts
2. ✅ Monitor the bot's behavior and logs
3. ✅ Adjust configuration based on your strategy
4. ✅ Only move to mainnet after successful devnet testing

## Additional Resources

- [Full Documentation](.devcontainer/README.md) - Detailed Codespaces guide
- [Main README](README.md) - Complete bot documentation
- [Solana Docs](https://docs.solana.com/) - Solana blockchain documentation
- [Raydium Docs](https://raydium.gitbook.io/raydium/) - Raydium protocol documentation

## Need Help?

- Check the [main README](README.md) for common issues
- Review the [devcontainer README](.devcontainer/README.md) for environment details
- Contact: Telegram @ZeeHolte

---

**Happy Trading! 🎯**

Remember: Always test thoroughly on devnet before using real funds on mainnet!
