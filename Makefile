ROOT_PATH=$(HOME)/dotfiles/env/x86_64-linux

switch:
	home-manager switch --flake $(ROOT_PATH)

switch-with-backup:
	home-manager switch --flake $(ROOT_PATH) -b backup

generations:
	home-manager generations --flake $(ROOT_PATH)
