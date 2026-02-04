# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Nix-based dotfiles repository using nix-darwin (macOS) and Home Manager (Linux) to manage system configurations across multiple platforms.

## Common Commands

```sh
# Apply configuration (auto-detects platform)
nix run .#switch

# Update flake inputs
nix run .#flake-update

# List all generations
nix run .#generations

# Remove old generations (e.g. older than 7 days)
nix run .#expire -- 7
```

### Linux only

```sh
# Apply with backup of existing files
nix run .#switch-with-backup
```

## Architecture

### Directory Structure

- `flake.nix` - Unified flake with darwinConfigurations and homeConfigurations
- `darwin/` - nix-darwin configuration (macOS)
  - `configuration.nix` - System configuration with home-manager integration
- `home/` - Home Manager configurations
  - `darwin.nix` - macOS home configuration (used via nix-darwin)
  - `linux.nix` - Linux x86_64 home configuration
- `modules/` - Platform-specific Nix modules
  - `xremap.nix` - Linux key remapping
- `programs/` - Reusable Nix modules for individual programs (zsh, git, vim, starship, mise, fzf, direnv, gh)
- `.config/` - Raw config files symlinked via Home Manager (nvim, gh)

### Configuration Flow

**macOS (nix-darwin)**:
1. `darwinConfigurations.ytakhs` in flake.nix
2. Loads `darwin/configuration.nix` which integrates home-manager
3. home-manager loads `home/darwin.nix`

**Linux (Home Manager)**:
1. `homeConfigurations."ytakhs@linux"` in flake.nix
2. Directly loads `home/linux.nix`

### Adding New Programs

1. Create `programs/<name>/default.nix` with the program configuration
2. Import it in the relevant home.nix file(s)

### Nix Formatting

Use `nixfmt-rfc-style` for formatting Nix files (installed via home.packages).
