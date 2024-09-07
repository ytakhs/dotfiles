DOTFILES_PATH=$(HOME)/dotfiles

switch:
	home-manager switch --flake $(DOTFILES_PATH)

switch-with-backup:
	home-manager switch --flake $(DOTFILES_PATH) -b backup

generations:
	home-manager generations --flake $(DOTFILES_PATH)
