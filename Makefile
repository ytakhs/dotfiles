ROOT_PATH=$(HOME)/dotfiles/env/x86_64-linux-desktop
MAIN_USERNAME = ytakhs

export DOTFILES_DYNAMIC_USERNAME ?=$(shell whoami)
export DOTFILES_DYNAMIC_HOMEDIR ?=$(HOME)

.PHONY: switch
switch:
	home-manager switch --flake $(ROOT_PATH)#$(MAIN_USERNAME)

.PHONY: switch-with-backup
switch-with-backup:
	home-manager switch --flake $(ROOT_PATH)#$(MAIN_USERNAME) -b backup

.PHONY: switch-dyn
switch-dyn:
	home-manager switch --flake $(ROOT_PATH)#$(DOTFILES_DYNAMIC_USERNAME) --impure

.PHONY: switch-dyn-with-backup
switch-dyn-with-backup:
	home-manager switch --flake $(ROOT_PATH)#$(DOTFILES_DYNAMIC_USERNAME) --impure -b backup

.PHONY: generations
generations:
	home-manager generations --flake $(ROOT_PATH)

.PHONY: expire
expire:
	home-manager expire-generations --flake $(ROOT_PATH) $(EXPIRE)

.PHONY: flake-update
flake-update:
	nix flake update --flake $(ROOT_PATH)
