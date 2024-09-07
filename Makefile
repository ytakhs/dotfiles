DOTFILES_PATH=$(HOME)/dotfiles

switch:
	home-manager switch --flake $(DOTFILES_PATH)

generations:
	home-manager generations --flake $(DOTFILES_PATH)
