{ config, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      save = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
      ignoreDups = true;
      ignoreSpace = true;
      extended = true;
      share = true;
    };

    sessionVariables = {
      GHQ_ROOT = "$HOME/dev/.ghq";
    };

    shellAliases = {
      lg = "lazygit";
    };

    initExtra = ''
      export PATH="$HOME/.cargo/bin:$PATH"

      bindkey -e

      function fzf-ghq-select() {
        local selected_dir=$(ghq list --full-path | fzf --query "$LBUFFER")
        if [[ -n "$selected_dir" ]]; then
          cd "$selected_dir"
          zle accept-line
        fi
      }
      zle -N fzf-ghq-select

      function fzf-git-switch() {
        local selected_branch=$(
          git branch --sort=committerdate --color=always \
          | fzf --ansi --preview='git log --oneline --graph --decorate --color=always -50 {+1}' \
          | awk '{print $1}' \
        )

        if [[ -n "$selected_branch" ]]; then
          git switch "$selected_branch"
          zle accept-line
        fi
      }
      zle -N fzf-git-switch

      bindkey '^g' fzf-ghq-select
      bindkey '^xf' fzf-git-switch
    '';
  };
}
