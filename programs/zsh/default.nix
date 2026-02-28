{
  config,
  pkgs,
  lib,
  ...
}:
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

    initContent =
      let
        zshConfigEarlyInit = lib.mkOrder 500 ''
          (( $${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"

          if [[ -r "$${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$${(%):-%n}.zsh" ]]; then
            source "$${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$${(%):-%n}.zsh"
          fi

          (( $${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"

        '';

        zshConfig = lib.mkOrder 1000 ''
          export GHQ_ROOT="$HOME/dev/ghq"
          export PATH="$HOME/.cargo/bin:$PATH"
          export PATH="$HOME/.local/bin:$PATH"

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

          source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
          source $HOME/.config/zsh/.p10k.zsh
        '';
      in

      lib.mkMerge [
        zshConfigEarlyInit
        zshConfig
      ];
  };
}
