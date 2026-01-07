# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Nix-based dotfiles repository using Home Manager to manage system configurations across multiple platforms.

## Common Commands

```sh
# Apply configuration (primary user on macOS)
make switch

# Apply with dynamic username (for different users)
make switch-dyn

# Apply with backup of existing files
make switch-with-backup
make switch-dyn-with-backup

# List all generations
make generations

# Remove old generations (set EXPIRE to date/time)
make expire EXPIRE="-7 days"

# Update flake inputs
make flake-update
```

## Architecture

### Directory Structure

- `env/` - Platform-specific Home Manager configurations
  - `aarch64-darwin/` - Apple Silicon macOS (primary)
  - `x86_64-linux/` - Linux x86_64
  - `x86_64-linux-desktop/` - Linux desktop with xremap
  - `aarch64-vscode-devcontainer/` - VS Code devcontainers

- `programs/` - Reusable Nix modules for individual programs (zsh, git, vim, starship, mise, fzf, direnv, gh)

- `.config/` - Raw config files symlinked via Home Manager (nvim, gh)

### Configuration Flow

Each platform has a `flake.nix` defining inputs (nixpkgs, home-manager) and a `home.nix` that:
1. Sets user-specific variables (username, homeDirectory)
2. Lists packages to install
3. Imports shared program modules from `programs/`
4. Defines file symlinks for `.config/` directories

### Adding New Programs

1. Create `programs/<name>/default.nix` with the program configuration
2. Import it in the relevant `home.nix` file(s)

### Nix Formatting

Use `nixfmt-rfc-style` for formatting Nix files (installed via home.packages).
