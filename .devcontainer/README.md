# GitHub Codespaces Development Environment

This directory contains the configuration for GitHub Codespaces, which provides a fully-featured cloud-based development environment for the Solana Raydium Sniper Bot.

## What is included

The devcontainer automatically sets up:

- **Node.js v20**: JavaScript/TypeScript runtime
- **npm**: Package manager for Node.js dependencies
- **TypeScript 5.3.3**: TypeScript compiler
- **ts-node**: Execute TypeScript directly
- **Rust**: Rust programming language (latest stable)
- **Solana CLI**: Command-line tools for Solana development
- **Git**: Version control system
- **Zsh with Oh My Zsh**: Enhanced shell experience

## VSCode Extensions

The following extensions are automatically installed:

- ESLint: JavaScript/TypeScript linting
- Prettier: Code formatting
- TypeScript: Enhanced TypeScript support
- Rust Analyzer: Rust language support
- LLDB: Debugging support

## Quick Start with Codespaces

1. Click the "Code" button on GitHub
2. Select "Create codespace on main"
3. Wait for the environment to build (first time takes ~5 minutes)
4. Once ready, configure your `.env` file
5. Run `npm run start` to begin

## Manual Setup (If needed)

If you need to rebuild or customize the environment:

```bash
# Rebuild the container
# Command Palette (F1) > "Codespaces: Rebuild Container"

# Or manually install components
npm install
```

## Configuration Files

- **devcontainer.json**: Main configuration for the development container
- **Dockerfile**: Base image and software installation

## Environment Variables

After the container starts, you'll need to configure your `.env` file:

```bash
cp .env.example .env
# Edit .env with your configuration
```

## Debugging

The devcontainer includes a VSCode debugging configuration:

1. Open start.ts
2. Set breakpoints as needed
3. Press F5 or use "Run and Debug" panel
4. Select "Debug Sniper Bot"

## Port Forwarding

If you add any web servers or services that need port access, they will be automatically forwarded by Codespaces.

## Persistence

- Your code changes are saved in the codespace
- Installed packages (node_modules) persist
- Environment variables (.env) persist
- Stop the codespace when not in use to save compute time

## Customization

You can customize the devcontainer by editing:

- `devcontainer.json`: Add VS Code extensions, features, or settings
- `Dockerfile`: Add system packages or tools
- `.vscode/settings.json`: Workspace-specific settings

## Troubleshooting

**Container build fails:**
- Check the build logs in the "Creating codespace..." dialog
- Try rebuilding: Command Palette > "Codespaces: Rebuild Container"

**Extensions not loading:**
- Reload the window: Command Palette > "Developer: Reload Window"
- Check `.devcontainer/devcontainer.json` extensions list

**npm install fails:**
- Check your internet connection
- Try: `rm -rf node_modules package-lock.json && npm install`

## Cost Considerations

GitHub Codespaces usage is billed based on:
- Compute time (when the codespace is running)
- Storage (persistent data)

Always stop your codespace when not in use to avoid unnecessary charges.

## Local Development Alternative

If you prefer local development over Codespaces, use the `setup.sh` script:

```bash
./setup.sh
```

This will install all necessary dependencies on your local machine.
