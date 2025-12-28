#!/bin/bash

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  Solana Raydium Sniper Bot - Environment Validator${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Track overall status
ALL_CHECKS_PASSED=true

# Function to print status
print_status() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✅ $2${NC}"
    else
        echo -e "${RED}❌ $2${NC}"
        ALL_CHECKS_PASSED=false
    fi
}

# Function to print warning
print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Function to print info
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Check Node.js
echo "Checking Node.js..."
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    print_status 0 "Node.js is installed: $NODE_VERSION"
else
    print_status 1 "Node.js is NOT installed"
fi
echo ""

# Check npm
echo "Checking npm..."
if command -v npm &> /dev/null; then
    NPM_VERSION=$(npm --version)
    print_status 0 "npm is installed: $NPM_VERSION"
else
    print_status 1 "npm is NOT installed"
fi
echo ""

# Check TypeScript
echo "Checking TypeScript..."
if command -v npx &> /dev/null && npx tsc --version &> /dev/null; then
    TS_VERSION=$(npx tsc --version)
    print_status 0 "TypeScript is installed: $TS_VERSION"
else
    print_status 1 "TypeScript is NOT installed"
fi
echo ""

# Check Rust
echo "Checking Rust..."
if command -v rustc &> /dev/null; then
    RUST_VERSION=$(rustc --version)
    print_status 0 "Rust is installed: $RUST_VERSION"
else
    print_status 1 "Rust is NOT installed"
fi
echo ""

# Check Cargo
echo "Checking Cargo..."
if command -v cargo &> /dev/null; then
    CARGO_VERSION=$(cargo --version)
    print_status 0 "Cargo is installed: $CARGO_VERSION"
else
    print_status 1 "Cargo is NOT installed"
fi
echo ""

# Check Solana CLI
echo "Checking Solana CLI..."
if command -v solana &> /dev/null; then
    SOLANA_VERSION=$(solana --version)
    print_status 0 "Solana CLI is installed: $SOLANA_VERSION"
    
    # Check Solana config
    echo ""
    print_info "Solana Configuration:"
    solana config get | grep -E "RPC URL:|WebSocket URL:|Keypair Path:" | sed 's/^/    /'
else
    print_status 1 "Solana CLI is NOT installed"
fi
echo ""

# Check for node_modules
echo "Checking npm dependencies..."
if [ -d "node_modules" ]; then
    print_status 0 "node_modules directory exists"
else
    print_status 1 "node_modules directory NOT found"
    print_info "Run 'npm install' to install dependencies"
fi
echo ""

# Check for required files
echo "Checking project files..."
REQUIRED_FILES=("package.json" "tsconfig.json" "start.ts" ".env")
for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        print_status 0 "$file exists"
    else
        if [ "$file" == ".env" ]; then
            print_warning "$file not found (copy .env.example to .env)"
        else
            print_status 1 "$file NOT found"
        fi
    fi
done
echo ""

# Check .env configuration
echo "Checking .env configuration..."
if [ -f ".env" ]; then
    # Check for critical variables
    CRITICAL_VARS=("PRIVATE_KEY" "RPC_ENDPOINT" "RPC_WEBSOCKET_ENDPOINT")
    for var in "${CRITICAL_VARS[@]}"; do
        if grep -q "^${var}=" .env && ! grep -q "^${var}=.*YOUR_.*_HERE" .env && ! grep -q "^${var}=.*XXXXX" .env; then
            print_status 0 "$var is configured"
        else
            print_warning "$var needs to be configured in .env"
        fi
    done
else
    print_warning ".env file not found - copy .env.example to .env and configure it"
fi
echo ""

# Check Git status
echo "Checking Git configuration..."
if command -v git &> /dev/null; then
    print_status 0 "Git is installed: $(git --version)"
    
    # Check if .env is in .gitignore
    if [ -f ".gitignore" ] && grep -q "^\.env$" .gitignore; then
        print_status 0 ".env is properly ignored by git"
    else
        print_warning ".env should be added to .gitignore"
    fi
else
    print_status 1 "Git is NOT installed"
fi
echo ""

# Final summary
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
if [ "$ALL_CHECKS_PASSED" = true ]; then
    echo -e "${GREEN}✅ All critical checks passed!${NC}"
    echo ""
    echo -e "${GREEN}You're ready to run the bot!${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Configure your .env file with your credentials"
    echo "  2. Run: npm run start"
else
    echo -e "${RED}❌ Some checks failed!${NC}"
    echo ""
    echo "Please fix the issues above before running the bot."
    echo ""
    echo "Common fixes:"
    echo "  - Run: npm install"
    echo "  - Copy: cp .env.example .env"
    echo "  - Configure your .env file"
fi
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Exit with appropriate code
if [ "$ALL_CHECKS_PASSED" = true ]; then
    exit 0
else
    exit 1
fi
