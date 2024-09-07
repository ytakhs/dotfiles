DOTFILES_PATH=$(HOME)/dotfiles

switch:
	home-manager switch --flake $(DOTFILES_PATH)
