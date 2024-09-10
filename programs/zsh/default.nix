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
      # fnm
      eval "$(fnm env --use-on-cd --shell zsh)"

      bindkey -e

      function peco-ghq-select() {
        local selected_dir=$(ghq list --full-path | peco --layout=bottom-up --query "$LBUFFER")
        if [[ -n "$selected_dir" ]]; then
          cd "$selected_dir"
          zle accept-line
        fi
      }
      zle -N peco-ghq-select

      function peco-git-switch() {
        local selected_branch="$(git branch | peco --layout=bottom-up | tr -d ' ')"

        if [[ -n "$selected_branch" ]]; then
          git switch "$selected_branch"
          zle accept-line
        fi
      }
      zle -N peco-git-switch

      bindkey '^g' peco-ghq-select
      bindkey '^xf' peco-git-switch
    '';
  };
}
