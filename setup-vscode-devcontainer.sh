#!/bin/bash

if command -v nix >/dev/null 2>&1; then
  mkdir -p ~/.config/nix
  echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
  nix run github:nix-community/home-manager/master -- switch --flake ~/dotfiles/env/aarch64-vscode-devcontainer#vscode -b backup
else
  echo "Nix is not installed"
fi
