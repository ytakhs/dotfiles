#!/bin/bash

if command -v nix >/dev/null 2>&1; then
  nix --extra-experimental-features nix-command --extra-experimental-features flakes run nixpkgs#home-manager/master -- init --switch --flake $(HOME)/dotfiles/env/aarch64-vscode-devcontainer#vscode
else
  echo "Nix is not installed"
fi
