{
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
    bat
    claude-code
    codex
    delta
    fd
    gh
    ghq
    gnupg
    git-wt
    hyperfine
    jq
    lazygit
    lua-language-server
    neovim
    nixd
    nixfmt
    opencode
    ripgrep
    rustup
    stylua
    tig
    tmux
    zsh-autosuggestions
    zsh-syntax-highlighting
  ];

  xdg.configFile = {
    "gh" = {
      source = ../.config/gh;
      recursive = true;
    };
    "ghostty" = {
      source = ../.config/ghostty;
      recursive = true;
    };
    "karabiner" = {
      source = ../.config/karabiner;
      recursive = true;
    };
    "lazygit" = {
      source = ../.config/lazygit;
      recursive = true;
    };
    "nvim" = {
      source = ../.config/nvim;
      recursive = true;
    };
    "tmux" = {
      source = ../.config/tmux;
      recursive = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "vim";
    XDG_CONFIG_HOME = "$HOME/.config";
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
