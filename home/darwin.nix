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
    # llm-agents
    llm-agents.claude-code
    llm-agents.opencode

    # nixpkgs
    bat
    bash-language-server
    bun
    delta
    fd
    gh
    ghq
    gnupg
    hyperfine
    jq
    lazygit
    lua-language-server
    neovim
    nixd
    nixfmt
    ripgrep
    rustup
    shellcheck
    socat
    stylua
    tmux
    tree-sitter
  ];

  home.file = {
    ".claude/skills" = {
      source = ../agent/skills;
      recursive = true;
    };
    ".local/bin/desktop-notifier" = {
      source = ../agent/scripts/desktop-notifier;
    };
  };

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
      source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dev/ghq/github.com/ytakhs/dotfiles/.config/nvim";
    };
    "tmux" = {
      source = ../.config/tmux;
      recursive = true;
    };
    "zsh" = {
      source = ../.config/zsh;
      recursive = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "vim";
    XDG_CONFIG_HOME = "$HOME/.config";
  };

  imports = [
    ../programs/direnv
    ../programs/fzf
    ../programs/git
    ../programs/mise
    ../programs/vim
    ../programs/zsh
  ];
}
