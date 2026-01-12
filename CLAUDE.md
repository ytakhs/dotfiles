# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Nix-based dotfiles repository using Home Manager to manage system configurations across multiple platforms.

## Common Commands

```sh
# Apply configuration (auto-detects platform)
nix run .#switch

# Apply with backup of existing files
nix run .#switch-with-backup

# List all generations
nix run .#generations

# Remove old generations
nix run .#expire -- "-7 days"

# Update flake inputs
nix run .#flake-update
```

## Architecture

### Directory Structure

- `flake.nix` - Unified flake with all homeConfigurations
- `home/` - Platform-specific Home Manager configurations
  - `darwin.nix` - Apple Silicon macOS
  - `linux.nix` - Linux x86_64
- `modules/` - Platform-specific Nix modules
  - `xremap.nix` - Linux key remapping
- `programs/` - Reusable Nix modules for individual programs (zsh, git, vim, starship, mise, fzf, direnv, gh)
- `.config/` - Raw config files symlinked via Home Manager (nvim, gh)

### Configuration Flow

The root `flake.nix` defines:
1. All inputs (nixpkgs, home-manager, zig-overlay, zls-overlay, xremap-flake)
2. Helper functions (`mkDarwinHome`, `mkLinuxHome`) for creating homeConfigurations
3. homeConfigurations for each platform (`ytakhs@darwin`, `ytakhs@linux`)

Each platform's home.nix (`home/darwin.nix`, `home/linux.nix`):
1. Sets user-specific variables (username, homeDirectory)
2. Lists packages to install
3. Imports shared program modules from `programs/`
4. Defines file symlinks for `.config/` directories

### Adding New Programs

1. Create `programs/<name>/default.nix` with the program configuration
2. Import it in the relevant home.nix file(s)

### Nix Formatting

Use `nixfmt-rfc-style` for formatting Nix files (installed via home.packages).
