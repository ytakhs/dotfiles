{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "ytakhs";
    userEmail = "21127627+ytakhs@users.noreply.github.com";

    extraConfig = {
      core = {
        pager = "delta --paging never";
      };

      pager = {
        log = "delta --paging never | less -+$LESS -R";
        show = "delta --paging never | less -+$LESS -R";
        diff = "delta --paging never | less -+$LESS -R";
        blame = "delta --paging never | less -+$LESS -R";
      };

      init = {
        defaultBranch = "main";
      };

      credential = {
        helper = "gh auth git-credential";
      };
    };
  };
}
