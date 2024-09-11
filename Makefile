ROOT_PATH=$(HOME)/dotfiles/env/x86_64-linux

.PHONY: switch
switch:
	home-manager switch --flake $(ROOT_PATH)

.PHONY: switch-with-backup
switch-with-backup:
	home-manager switch --flake $(ROOT_PATH) -b backup

.PHONY: generations
generations:
	home-manager generations --flake $(ROOT_PATH)

.PHONY: flake-update
flake-update:
	nix flake update --flake $(ROOT_PATH)

.PHONY: init
init:
	nix run home-manager/master -- init --switch $(ROOT_PATH) -b backup
