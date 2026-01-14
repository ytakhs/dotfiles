{
  config,
  pkgs,
  homeDirectory,
  username,
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
    nixfmt
    nil
    # rust
    rustup
    # unfree packages
    claude-code
  ];

  xdg.configFile = {
    "nvim" = {
      source = ../.config/nvim;
      recursive = true;
    };
    "gh" = {
      source = ../.config/gh;
      recursive = true;
    };
    "ghostty" = {
      source = ../.config/ghostty;
      recursive = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

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
