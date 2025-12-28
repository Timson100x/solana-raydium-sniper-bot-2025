#!/bin/bash

# Test script to validate the development environment setup
# This script checks that all components are properly configured

set -e

echo "=========================================="
echo "Solana Raydium Sniper Bot - Environment Test"
echo "=========================================="
echo ""

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counter
TESTS_PASSED=0
TESTS_FAILED=0

# Function to print test result
test_result() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $2"
        ((TESTS_PASSED++))
    else
        echo -e "${RED}✗${NC} $2"
        ((TESTS_FAILED++))
    fi
}

# Test Node.js
echo "Testing Node.js..."
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    test_result 0 "Node.js is installed: $NODE_VERSION"
else
    test_result 1 "Node.js is not installed"
fi

# Test npm
echo "Testing npm..."
if command -v npm &> /dev/null; then
    NPM_VERSION=$(npm --version)
    test_result 0 "npm is installed: $NPM_VERSION"
else
    test_result 1 "npm is not installed"
fi

# Test TypeScript
echo "Testing TypeScript..."
if npx tsc --version &> /dev/null; then
    TS_VERSION=$(npx tsc --version)
    test_result 0 "TypeScript is available: $TS_VERSION"
else
    test_result 1 "TypeScript is not available"
fi

# Test ts-node
echo "Testing ts-node..."
if npx ts-node --version &> /dev/null; then
    TS_NODE_VERSION=$(npx ts-node --version)
    test_result 0 "ts-node is available: $TS_NODE_VERSION"
else
    test_result 1 "ts-node is not available"
fi

# Test node_modules
echo "Testing dependencies..."
if [ -d "node_modules" ]; then
    test_result 0 "node_modules directory exists"
else
    test_result 1 "node_modules directory not found - run 'npm install'"
fi

# Test TypeScript compilation
echo "Testing TypeScript compilation..."
if npx tsc --noEmit &> /dev/null; then
    test_result 0 "TypeScript compilation successful"
else
    test_result 1 "TypeScript compilation failed"
    echo "   Run 'npx tsc --noEmit' to see errors"
fi

# Test .env file
echo "Testing configuration..."
if [ -f ".env" ]; then
    test_result 0 ".env file exists"
    
    # Check for required variables
    if grep -q "PRIVATE_KEY=" .env && grep -q "RPC_ENDPOINT=" .env; then
        test_result 0 ".env contains required variables"
    else
        test_result 1 ".env missing required variables"
    fi
else
    test_result 1 ".env file not found - copy from .env.example"
fi

# Test important files
echo "Testing project structure..."
test -f "start.ts" && test_result 0 "start.ts exists" || test_result 1 "start.ts not found"
test -f "package.json" && test_result 0 "package.json exists" || test_result 1 "package.json not found"
test -f "tsconfig.json" && test_result 0 "tsconfig.json exists" || test_result 1 "tsconfig.json not found"

# Test devcontainer
echo "Testing devcontainer configuration..."
test -f ".devcontainer/devcontainer.json" && test_result 0 "devcontainer.json exists" || test_result 1 "devcontainer.json not found"
test -f ".devcontainer/Dockerfile" && test_result 0 "Dockerfile exists" || test_result 1 "Dockerfile not found"

# Test VSCode configuration
echo "Testing VSCode configuration..."
test -f ".vscode/launch.json" && test_result 0 "launch.json exists" || test_result 1 "launch.json not found"
test -f ".vscode/settings.json" && test_result 0 "settings.json exists" || test_result 1 "settings.json not found"

# Optional: Test Rust (not critical for TypeScript bot)
echo "Testing Rust (optional)..."
if command -v rustc &> /dev/null; then
    RUST_VERSION=$(rustc --version)
    echo -e "${GREEN}ℹ${NC} Rust is installed: $RUST_VERSION"
else
    echo -e "${YELLOW}ℹ${NC} Rust is not installed (optional for this bot)"
fi

# Optional: Test Solana CLI (not critical for bot operation)
echo "Testing Solana CLI (optional)..."
if command -v solana &> /dev/null; then
    SOLANA_VERSION=$(solana --version 2>&1 | head -1)
    echo -e "${GREEN}ℹ${NC} Solana CLI is installed: $SOLANA_VERSION"
else
    echo -e "${YELLOW}ℹ${NC} Solana CLI is not installed (optional, install with setup.sh)"
fi

# Summary
echo ""
echo "=========================================="
echo "Test Summary"
echo "=========================================="
echo -e "Tests passed: ${GREEN}$TESTS_PASSED${NC}"
echo -e "Tests failed: ${RED}$TESTS_FAILED${NC}"
echo ""

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ All critical tests passed!${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Update .env with your configuration"
    echo "2. Run 'npm run start' to start the bot"
    exit 0
else
    echo -e "${RED}✗ Some tests failed. Please fix the issues above.${NC}"
    exit 1
fi
