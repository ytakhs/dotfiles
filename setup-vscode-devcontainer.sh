#!/bin/bash

if [ which nix >/dev/null 2>&1 ]; then
  nix run nixpkgs#home-manager/master -- init --switch --flake $(HOME)/dotfiles/env/aarch64-darwin-vscode#vscode
else
  echo "Nix is not installed"
fi
