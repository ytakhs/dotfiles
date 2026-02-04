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
    fastfetch
    claude-code
    codex
    delta
    gh
    ghq
    gnupg
    git-wt
    hyperfine
    jq
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

  home.file = {
    ".tmux.conf" = {
      source = ../.tmux.conf;
    };
  };

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
    "karabiner" = {
      source = ../.config/karabiner;
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
