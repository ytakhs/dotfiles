ROOT_PATH=$(HOME)/dotfiles/env/x86_64-linux
MAIN_USERNAME = ytakhs

export DOTFILES_SANDBOX_USERNAME ?=$(shell whoami)
export DOTFILES_SANDBOX_HOMEDIR ?=$(HOME)

.PHONY: switch
switch:
	home-manager switch --flake $(ROOT_PATH)#$(MAIN_USERNAME)

.PHONY: switch-with-backup
switch-with-backup:
	home-manager switch --flake $(ROOT_PATH)#$(MAIN_USERNAME) -b backup

.PHONY: switch-dyn
switch-dyn:
	home-manager switch --flake $(ROOT_PATH)#$(DOTFILES_SANDBOX_USERNAME) --impure

.PHONY: switch-dyn-with-backup
switch-dyn:
	home-manager switch --flake $(ROOT_PATH)#$(DOTFILES_SANDBOX_USERNAME) --impure -b backup

.PHONY: generations
generations:
	home-manager generations --flake $(ROOT_PATH)#$(MAIN_USERNAME)

.PHONY: flake-update
flake-update:
	nix flake update --flake $(ROOT_PATH)
