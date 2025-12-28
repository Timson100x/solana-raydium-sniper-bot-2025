# DevContainer Setup for Solana Raydium Sniper Bot

This directory contains the configuration for GitHub Codespaces and VS Code DevContainers.

## What's Included

### Base Image
- **Node.js 20** (Bookworm/Debian-based)
- TypeScript and ts-node support
- All Node.js development tools

### Additional Features
- **Rust Toolchain** (latest stable)
  - Required for Solana CLI and related tools
  - Includes cargo, rustc, and rust-analyzer
  
- **Solana CLI** (installed via setup script)
  - Full Solana command-line tools
  - Configured for devnet by default
  
- **Common Utilities**
  - Zsh with Oh My Zsh
  - Git, curl, wget
  - Build essentials

### VS Code Extensions

Automatically installed:
- **ESLint** - JavaScript/TypeScript linting
- **Prettier** - Code formatting
- **TypeScript** - Enhanced TypeScript support
- **Error Lens** - Inline error messages
- **Rust Analyzer** - Rust language support
- **Rust Doc Viewer** - View Rust documentation

## Using GitHub Codespaces

1. Navigate to the repository on GitHub
2. Click **Code** → **Codespaces** → **Create codespace**
3. Wait for the environment to build (3-5 minutes first time)
4. Configure your `.env` file
5. Start coding!

## Using VS Code DevContainers (Local)

### Prerequisites
- Docker Desktop installed and running
- VS Code with "Remote - Containers" extension

### Steps
1. Open the project in VS Code
2. Press `F1` → "Dev Containers: Reopen in Container"
3. Wait for container to build
4. Configure your `.env` file
5. Start developing!

## Post-Creation Setup

The `setup.sh` script runs automatically and:
1. Updates system packages
2. Installs Solana CLI
3. Verifies Rust installation
4. Installs npm dependencies
5. Creates `.env` from `.env.example` if needed
6. Configures Solana for devnet

## Environment Variables

The container sets:
- `PATH` includes Solana CLI binaries
- Development tools are ready to use

## Customization

### Adding More Extensions

Edit `devcontainer.json`:

```json
"extensions": [
  "existing.extension",
  "your.new-extension"
]
```

### Installing Additional Tools

Edit `setup.sh` to add more installation steps.

### Changing Base Image

Edit `devcontainer.json`:

```json
"image": "mcr.microsoft.com/devcontainers/typescript-node:1-18-bookworm"
```

## Troubleshooting

### Container Fails to Build

1. Check Docker is running
2. Try rebuilding: `F1` → "Dev Containers: Rebuild Container"
3. Check Docker logs for errors

### Solana CLI Not Found

The PATH should be automatically configured. If not:

```bash
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
```

### npm install Fails

Try clearing cache:

```bash
rm -rf node_modules package-lock.json
npm install
```

## Resources

- [VS Code DevContainers Docs](https://code.visualstudio.com/docs/devcontainers/containers)
- [GitHub Codespaces Docs](https://docs.github.com/en/codespaces)
- [Solana CLI Docs](https://docs.solana.com/cli)
