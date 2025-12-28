# Quick Reference Guide

## Common Commands

### Setup
```bash
# Install dependencies
npm install

# Validate setup
./validate-setup.sh

# Create .env from template
cp .env.example .env
```

### Solana CLI
```bash
# Check Solana version
solana --version

# Check current config
solana config get

# Set cluster (devnet for testing)
solana config set --url https://api.devnet.solana.com

# Set cluster (mainnet for production)
solana config set --url https://api.mainnet-beta.solana.com

# Generate new wallet
solana-keygen new --outfile ~/my-wallet.json

# Get wallet address from keypair
solana-keygen pubkey ~/my-wallet.json

# Check balance
solana balance <WALLET_ADDRESS>

# Request devnet airdrop (2 SOL max)
solana airdrop 2 <WALLET_ADDRESS>

# View transaction
solana confirm <SIGNATURE>
```

### Running the Bot
```bash
# Start the bot
npm run start

# Start with debug logging (set LOG_LEVEL=debug in .env)
npm run start

# Stop the bot
Ctrl+C
```

### Development
```bash
# Check TypeScript compilation
npx tsc --noEmit

# Format code (if prettier is configured)
npx prettier --write .

# Debug in VS Code
Press F5 or use Run > Start Debugging
```

### Token Operations
```bash
# View SPL token accounts
spl-token accounts

# Check token balance
spl-token balance <TOKEN_MINT_ADDRESS>

# Wrap SOL to WSOL (for trading)
# Use Jupiter: https://jup.ag/
```

### Monitoring
```bash
# View transaction on Solscan
https://solscan.io/tx/<SIGNATURE>

# View on Solscan Devnet
https://solscan.io/tx/<SIGNATURE>?cluster=devnet

# View token on DexScreener
https://dexscreener.com/solana/<TOKEN_MINT>
```

### RPC Testing
```bash
# Test RPC endpoint
curl -X POST -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"getVersion"}' \
  https://api.devnet.solana.com

# Test WebSocket (requires wscat)
wscat -c wss://api.devnet.solana.com
```

### Environment Variables
Key variables to configure in `.env`:

| Variable | Description | Example |
|----------|-------------|---------|
| `PRIVATE_KEY` | Wallet private key (base58) | Your key here |
| `RPC_ENDPOINT` | HTTP RPC endpoint | `https://api.devnet.solana.com` |
| `RPC_WEBSOCKET_ENDPOINT` | WebSocket endpoint | `wss://api.devnet.solana.com` |
| `QUOTE_MINT` | Trading token | `WSOL` or `USDC` |
| `QUOTE_AMOUNT` | Amount per trade | `0.01` (for testing) |
| `COMMITMENT_LEVEL` | Confirmation level | `finalized` |
| `AUTO_SELL` | Enable auto-sell | `true` or `false` |
| `TAKE_PROFIT` | Profit target % | `50` |
| `STOP_LOSS` | Loss limit % | `30` |
| `USE_SNIPE_LIST` | Use snipe list | `true` or `false` |

### Troubleshooting

#### Issue: No token account found
```bash
# Solution: Wrap SOL to WSOL or get USDC
# Visit: https://jup.ag/
```

#### Issue: RPC errors (410 Gone)
```bash
# Solution: Use better RPC provider
# Recommended: Helius, QuickNode
```

#### Issue: Empty transactions
```bash
# Solution: Set commitment to finalized
# In .env: COMMITMENT_LEVEL=finalized
```

#### Issue: Bot not detecting pools
```bash
# Check: WebSocket endpoint configured correctly
# Check: Using correct QUOTE_MINT (WSOL/USDC)
# Check: Snipe list if USE_SNIPE_LIST=true
```

## Useful Links

- [Solana Docs](https://docs.solana.com/)
- [Raydium Docs](https://docs.raydium.io/)
- [Helius RPC](https://helius.dev)
- [QuickNode](https://quicknode.com)
- [Jupiter (Wrap SOL)](https://jup.ag/)
- [Birdeye API](https://docs.birdeye.so/)
- [Solscan Explorer](https://solscan.io/)
- [DexScreener](https://dexscreener.com/)

## Safety Checklist

- [ ] Test on devnet first
- [ ] Use small amounts initially
- [ ] Keep more SOL than WSOL for gas
- [ ] Never commit `.env` file
- [ ] Use premium RPC for production
- [ ] Monitor logs carefully
- [ ] Set reasonable TP/SL values
- [ ] Understand the risks

---

For detailed instructions, see [DEVELOPMENT.md](DEVELOPMENT.md)
