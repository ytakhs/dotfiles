# Repository Guidelines

## Project Structure & Module Organization

- `flake.nix` and `flake.lock` define the Nix flake for all systems.
- `darwin/` contains nix-darwin configuration (macOS), including `darwin/configuration.nix`.
- `home/` contains Home Manager configs: `home/darwin.nix` and `home/linux.nix`.
- `modules/` holds platform-specific modules (currently `modules/xremap.nix`).
- `programs/` contains reusable program modules, each under `programs/<name>/default.nix`.
- `examples/` stores app-specific sample configs (for example Neovim snippets).

## Build, Test, and Development Commands

- `nix run .#switch` applies the configuration for the current platform.
- `nix run .#flake-update` updates flake inputs.
- `nix run .#generations` lists generations (darwin-rebuild on macOS, Home Manager on Linux).
- `nix run .#expire -- 7` removes generations older than 7 days.
- Linux only:
  - `nix run .#switch-with-backup` applies with a backup of existing files.

## Coding Style & Naming Conventions

- Format Nix files with `nixfmt-rfc-style`.
- Prefer small, focused modules; keep settings close to the relevant `programs/<name>/default.nix`.
- Follow existing naming patterns for modules and options; new programs should live at
  `programs/<name>/default.nix` and be imported in `home/darwin.nix` and/or `home/linux.nix`.

## Testing Guidelines

- No automated test suite is defined.
- Validate changes by running `nix run .#switch` on the target platform and verifying expected behavior.

## Commit & Pull Request Guidelines

- Commit messages typically follow a conventional style: `feat: ...`, `refactor(scope): ...`,
  or short imperative updates like `update ...`. Use a clear, scoped summary.
- PRs should describe affected platform(s) and notable behavior changes.
- Link related issues if applicable and mention manual verification steps.

## Configuration Tips

- macOS flow: `darwin/configuration.nix` integrates Home Manager and loads `home/darwin.nix`.
- Linux flow: `home/linux.nix` is referenced directly by the flake as `ytakhs@linux`.
