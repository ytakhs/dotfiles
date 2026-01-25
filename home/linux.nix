{
  config,
  pkgs,
  homeDirectory,
  username,
  lib,
  xremap-flake,
  ...
}:

{
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    # base
    delta
    ghq
    jq
    tig
    hyperfine
    fastfetch
    neovim
    # zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    # nix development
    nixfmt-rfc-style
    nil
    # rust
    rustup
    # c/c++
    clang-tools
    # wasm
    wasm-tools
  ];

  home.file = {
    ".config/nvim" = {
      source = ../.config/nvim;
      recursive = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "vim";
    LANG = "en_US.UTF-8";
  };

  programs.home-manager.enable = true;

  imports = [
    ../modules/xremap.nix
    ../programs/zsh
    ../programs/git
    ../programs/gh
    ../programs/vim
    ../programs/starship
    ../programs/mise
    ../programs/fzf
  ];
}
