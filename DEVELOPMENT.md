# Development Guide

This guide will help you set up and develop the Solana Raydium Sniper Bot in GitHub Codespaces or your local environment.

## Table of Contents

1. [Quick Start with GitHub Codespaces](#quick-start-with-github-codespaces)
2. [Local Development Setup](#local-development-setup)
3. [Configuration](#configuration)
4. [Testing on Devnet](#testing-on-devnet)
5. [Running the Bot](#running-the-bot)
6. [Debugging](#debugging)
7. [Project Structure](#project-structure)
8. [Common Issues](#common-issues)

---

## Quick Start with GitHub Codespaces

GitHub Codespaces provides a fully configured development environment in the cloud.

### 1. Launch Codespace

1. Navigate to the repository on GitHub
2. Click the **Code** button
3. Select **Codespaces** tab
4. Click **Create codespace on main** (or your branch)

The environment will automatically:
- Install Node.js and TypeScript
- Install Solana CLI
- Install Rust toolchain
- Install all npm dependencies
- Configure development tools

### 2. Configure Environment

After the Codespace starts:

```bash
# Copy the example environment file
cp .env.example .env

# Edit the .env file with your configuration
# Use VS Code editor or nano/vim
```

### 3. Set Up for Testing

For safe testing on Solana Devnet:

```bash
# Configure Solana CLI for devnet
solana config set --url https://api.devnet.solana.com

# Generate a test wallet (if you don't have one)
solana-keygen new --outfile ~/devnet-wallet.json

# Get the wallet address
solana-keygen pubkey ~/devnet-wallet.json

# Request devnet SOL (airdrop)
solana airdrop 2 <YOUR_WALLET_ADDRESS>

# Convert to base58 format for .env
cat ~/devnet-wallet.json | python3 -c "import sys, json, base58; print(base58.b58encode(bytes(json.load(sys.stdin))).decode())"
```

### 4. Update Configuration

Edit `.env` file:

```bash
# Use your devnet wallet private key
PRIVATE_KEY=<base58_private_key_from_above>

# Use devnet endpoints
RPC_ENDPOINT=https://api.devnet.solana.com
RPC_WEBSOCKET_ENDPOINT=wss://api.devnet.solana.com

# Use smaller amounts for testing
QUOTE_AMOUNT=0.01
QUOTE_MINT=WSOL

# Test mode settings
COMMITMENT_LEVEL=finalized
AUTO_SELL=false
USE_SNIPE_LIST=true
```

### 5. Run the Bot

```bash
npm run start
```

---

## Local Development Setup

### Prerequisites

- Node.js 16+ and npm
- Rust toolchain (latest stable)
- Solana CLI
- Git

### Installation

1. **Clone the repository:**

```bash
git clone https://github.com/Timson100x/solana-raydium-sniper-bot-2025.git
cd solana-raydium-sniper-bot-2025
```

2. **Install Solana CLI:**

```bash
sh -c "$(curl -sSfL https://release.solana.com/stable/install)"
export PATH="/home/$USER/.local/share/solana/install/active_release/bin:$PATH"
```

3. **Install Rust:**

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
```

4. **Install Node.js dependencies:**

```bash
npm install
```

5. **Configure environment:**

```bash
cp .env.example .env
# Edit .env with your configuration
```

---

## Configuration

### Environment Variables

The bot is configured via the `.env` file. Here are the key settings:

#### Wallet & RPC

- `PRIVATE_KEY`: Your wallet private key (base58 format)
- `RPC_ENDPOINT`: HTTP RPC endpoint
- `RPC_WEBSOCKET_ENDPOINT`: WebSocket RPC endpoint

#### Trading Parameters

- `QUOTE_MINT`: Token to trade with (`WSOL` or `USDC`)
- `QUOTE_AMOUNT`: Amount per trade
- `TAKE_PROFIT`: Profit target percentage (default: 50%)
- `STOP_LOSS`: Loss limit percentage (default: 30%)

#### Filters

- `CHECK_IF_MINT_IS_RENOUNCED`: Only trade renounced tokens
- `MIN_POOL_SIZE`: Minimum liquidity pool size
- `USE_SNIPE_LIST`: Only trade tokens in `snipe-list.txt`

#### Auto-Sell

- `AUTO_SELL`: Enable automatic selling
- `AUTO_SELL_DELAY`: Delay before selling (ms)
- `MAX_SELL_RETRIES`: Maximum sell attempts

### RPC Providers

For production (mainnet), use a premium RPC provider:

1. **Helius** (Recommended)
   - Website: https://helius.dev
   - Free tier available
   - Fast and reliable

2. **QuickNode**
   - Website: https://quicknode.com
   - Free tier available

3. **Shyft**
   - Website: https://shyft.to
   - Good for testing

---

## Testing on Devnet

**Always test on devnet before running on mainnet!**

### Setup Devnet Environment

1. **Configure Solana CLI:**

```bash
solana config set --url https://api.devnet.solana.com
```

2. **Create Test Wallet:**

```bash
solana-keygen new --outfile ~/devnet-wallet.json
```

3. **Get Devnet SOL:**

```bash
solana airdrop 2 $(solana-keygen pubkey ~/devnet-wallet.json)
```

4. **Convert Wallet to Base58:**

The bot requires private key in base58 format:

```bash
# Using Python
cat ~/devnet-wallet.json | python3 -c "import sys, json, base58; print(base58.b58encode(bytes(json.load(sys.stdin))).decode())"

# OR using Node.js
node -e "const fs = require('fs'); const bs58 = require('bs58'); const key = JSON.parse(fs.readFileSync(process.env.HOME + '/devnet-wallet.json')); console.log(bs58.encode(Buffer.from(key)));"
```

5. **Prepare WSOL for Trading:**

Since Raydium pools typically use WSOL:

```bash
# Get your wallet address
WALLET_ADDRESS=$(solana-keygen pubkey ~/devnet-wallet.json)

# Wrap SOL to WSOL (using Jupiter or similar)
# On devnet, you may need to use test tools or create wrapped SOL manually
```

### Devnet Testing Checklist

- [ ] Wallet has devnet SOL
- [ ] `.env` configured for devnet endpoints
- [ ] `QUOTE_AMOUNT` set to small value (e.g., 0.01)
- [ ] `AUTO_SELL` disabled or set to true with monitoring
- [ ] Logs set to `LOG_LEVEL=debug` for detailed output

---

## Running the Bot

### Start the Bot

```bash
npm run start
```

### What Happens

1. Bot connects to Solana blockchain via RPC/WebSocket
2. Listens for new Raydium liquidity pools
3. Filters pools based on your criteria
4. Executes buy transactions when conditions are met
5. (If AUTO_SELL enabled) Monitors positions and sells based on TP/SL

### Monitoring

The bot outputs logs in real-time:

```
[INFO] Wallet Address: ABC123...
[INFO] Snipe list: false
[INFO] Check mint renounced: true
[INFO] Buy amount: 0.1 WSOL
[INFO] Auto sell: true
[INFO] Listening for raydium changes: 12345
[INFO] Sent buy tx { mint: '...', signature: '...' }
[INFO] Confirmed buy tx... Bought at: 0.0001 SOL
```

### Stop the Bot

Press `Ctrl+C` to gracefully stop the bot.

---

## Debugging

### Enable Debug Logging

Set in `.env`:

```bash
LOG_LEVEL=debug
```

### Common Debugging Tasks

#### 1. Check Solana Configuration

```bash
solana config get
```

#### 2. Check Wallet Balance

```bash
solana balance <YOUR_WALLET_ADDRESS>
```

#### 3. Verify Token Accounts

```bash
spl-token accounts
```

#### 4. Test RPC Connection

```bash
curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","id":1,"method":"getVersion"}' $RPC_ENDPOINT
```

#### 5. View Transaction Details

```bash
solana confirm <TRANSACTION_SIGNATURE>
```

### Using TypeScript Debugging

In VS Code (Codespaces):

1. Set breakpoints in your code
2. Press `F5` or use Run > Start Debugging
3. The bot will start with debugger attached

Debug configuration (`.vscode/launch.json`):

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
      }
    }
  ]
}
```

---

## Project Structure

```
solana-raydium-sniper-bot-2025/
├── .devcontainer/          # GitHub Codespaces configuration
│   ├── devcontainer.json   # Container definition
│   └── setup.sh           # Setup script
├── constants/             # Constants and configuration
│   ├── constants.ts
│   └── index.ts
├── liquidity/            # Liquidity pool handling
│   ├── liquidity.ts      # Pool operations
│   └── index.ts
├── market/               # Market data handling
│   └── (market files)
├── types/                # TypeScript type definitions
├── utils/                # Utility functions
│   ├── utils.ts          # Helper functions
│   ├── logger.ts         # Logging utilities
│   └── index.ts
├── readme/               # Documentation images
├── .env.example          # Environment template
├── .env                  # Your config (gitignored)
├── start.ts             # Main bot entry point
├── package.json         # Node.js dependencies
├── tsconfig.json        # TypeScript configuration
├── snipe-list.txt       # Token addresses to snipe
└── README.md            # User documentation
```

### Key Files

- **`start.ts`**: Main bot logic, listens for pools and executes trades
- **`liquidity/liquidity.ts`**: Raydium pool interaction
- **`utils/utils.ts`**: Helper functions for token prices, retries
- **`.env`**: Configuration (never commit this!)

---

## Common Issues

### Issue: "No SOL token account found in wallet"

**Solution:** You need to have WSOL or USDC in your wallet.

```bash
# Use Jupiter to wrap SOL to WSOL
# Visit: https://jup.ag/
```

### Issue: "410 Gone: RPC call disabled"

**Solution:** Your RPC provider doesn't support required methods. Switch to Helius or QuickNode.

### Issue: Empty transactions on Solscan

**Solution:** Change commitment level to `finalized` in `.env`:

```bash
COMMITMENT_LEVEL=finalized
```

### Issue: Bot not detecting new pools

**Checklist:**
1. RPC WebSocket endpoint correctly configured
2. Sufficient RPC rate limits
3. `QUOTE_MINT` matches pool you're targeting
4. If using snipe list, ensure `USE_SNIPE_LIST=true` and addresses in `snipe-list.txt`

### Issue: Transactions failing

**Possible causes:**
1. Insufficient SOL for transaction fees
2. Network congestion
3. Slippage too high (bot sets `minAmountOut: 0`)
4. Token already launched before bot detected

---

## Best Practices

1. **Always test on devnet first**
2. **Start with small amounts on mainnet**
3. **Use premium RPC providers for speed**
4. **Monitor logs carefully**
5. **Keep more SOL than WSOL for gas fees** (recommended: 0.9 SOL / 0.1 WSOL)
6. **Never commit your `.env` file**
7. **Review and update snipe list regularly**
8. **Set reasonable TP/SL values**

---

## Additional Resources

- [Solana Documentation](https://docs.solana.com/)
- [Raydium Documentation](https://docs.raydium.io/)
- [Solana Cookbook](https://solanacookbook.com/)
- [Helius RPC](https://helius.dev)
- [Birdeye API](https://docs.birdeye.so/)

---

## Getting Help

If you encounter issues:

1. Check the [Common Issues](#common-issues) section
2. Enable debug logging (`LOG_LEVEL=debug`)
3. Review transaction on [Solscan](https://solscan.io/)
4. Check RPC provider status
5. Create an issue on GitHub with detailed logs

---

**⚠️ Disclaimer:** Use this bot at your own risk. Crypto trading involves substantial risk of loss. Always test thoroughly and never invest more than you can afford to lose.
