{
  config,
  pkgs,
  homeDirectory,
  username,
  lib,
  ...
}:

{
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    # base
    gh
    delta
    ghq
    jq
    tig
    hyperfine
    fastfetch
    neovim
    gnupg
    zellij
    ripgrep
    # lua
    lua-language-server
    stylua
    # zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    # nix development
    nixfmt-rfc-style
    nil
    # rust
    rustup
    # unfree packages
    claude-code
  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "claude-code"
    ];

  home.file = {
    ".config/nvim" = {
      source = ../.config/nvim;
      recursive = true;
    };
    ".config/gh" = {
      source = ../.config/gh;
      recursive = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.home-manager.enable = true;

  imports = [
    ../programs/zsh
    ../programs/git
    ../programs/vim
    ../programs/starship
    ../programs/mise
    ../programs/fzf
    ../programs/direnv
  ];
}
