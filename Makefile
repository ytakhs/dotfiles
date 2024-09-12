ROOT_PATH=$(HOME)/dotfiles/env/x86_64-linux
MAIN_USERNAME = ytakhs

export DOTFILES_SANDBOX_USERNAME ?=$(whoami) 
export DOTFILES_SANDBOX_HOMEDIR ?=$(HOME)

.PHONY: switch
switch:
	home-manager switch --flake $(ROOT_PATH)#$(MAIN_USERNAME)

.PHONY: switch-with-backup
switch-with-backup:
	home-manager switch --flake $(ROOT_PATH)#$(MAIN_USERNAME) -b backup

.PHONY: generations
generations:
	home-manager generations --flake $(ROOT_PATH)#$(MAIN_USERNAME)

.PHONY: flake-update
flake-update:
	nix flake update --flake $(ROOT_PATH)

.PHONY: init
init:
	nix run home-manager/master -- init --switch $(ROOT_PATH)#$(MAIN_USERNAME) -b backup

.PHONY: init-sandbox
init-sandbox:
	nix run home-manager/master -- init --switch $(ROOT_PATH)#$(DOTFILES_SANDBOX_USERNAME) -b backup --impure

.PHONY: switch-sandbox
switch-sandbox:
	home-manager switch --flake $(ROOT_PATH)#$(DOTFILES_SANDBOX_USERNAME) -b backup
