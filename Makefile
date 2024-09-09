ROOT_PATH=$(HOME)/dotfiles/env/x86_64-linux

switch:
	home-manager switch --flake $(ROOT_PATH)

switch-with-backup:
	home-manager switch --flake $(ROOT_PATH) -b backup

generations:
	home-manager generations --flake $(ROOT_PATH)

flake-update:
	nix flake update --flake $(ROOT_PATH)

init:
	nix run home-manager/master -- init --switch $(ROOT_PATH)
