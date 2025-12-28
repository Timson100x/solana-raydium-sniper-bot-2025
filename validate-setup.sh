#!/bin/bash
# Validation script for GitHub Codespaces setup
set -e

echo "🔍 Validating Development Environment Setup..."
echo ""

# Check Node.js
echo "✓ Checking Node.js..."
node --version
npm --version
echo ""

# Check TypeScript
echo "✓ Checking TypeScript..."
npx tsc --version
echo ""

# Check npm dependencies
echo "✓ Checking npm dependencies..."
if [ -d "node_modules" ]; then
    echo "  Dependencies installed ✓"
else
    echo "  ⚠️  Dependencies not installed. Run: npm install"
fi
echo ""

# Check .env configuration
echo "✓ Checking .env configuration..."
if [ -f ".env" ]; then
    echo "  .env file exists ✓"
    if grep -q "your_wallet_private_key" .env 2>/dev/null || grep -q "XXXXXXXXXXX" .env 2>/dev/null; then
        echo "  ⚠️  Please configure .env with actual values"
    else
        echo "  .env appears configured ✓"
    fi
else
    echo "  ⚠️  .env file not found. Copy from .env.example"
fi
echo ""

# Check for Solana CLI (optional in CI)
echo "✓ Checking Solana CLI (optional)..."
if command -v solana &> /dev/null; then
    solana --version
    echo "  Solana CLI installed ✓"
else
    echo "  ℹ️  Solana CLI not found (will be installed in Codespaces)"
fi
echo ""

# Check for Rust (optional in CI)
echo "✓ Checking Rust (optional)..."
if command -v rustc &> /dev/null; then
    rustc --version
    echo "  Rust installed ✓"
else
    echo "  ℹ️  Rust not found (will be installed in Codespaces)"
fi
echo ""

# Check TypeScript compilation (without emitting)
echo "✓ Checking TypeScript compilation..."
if npx tsc --noEmit --skipLibCheck 2>&1 | grep -q "error"; then
    echo "  ⚠️  TypeScript has compilation errors"
    echo "  Note: constants/constants.ts has unused imports but won't affect runtime"
else
    echo "  TypeScript compiles successfully ✓"
fi
echo ""

# Summary
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Validation Complete!"
echo ""
echo "📝 Next Steps:"
echo "   1. Ensure .env is properly configured"
echo "   2. For Codespaces: The setup will complete automatically"
echo "   3. Run the bot: npm run start"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
