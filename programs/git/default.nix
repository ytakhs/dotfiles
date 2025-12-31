{ pkgs, ... }:
{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "ytakhs";
        email = "21127627+ytakhs@users.noreply.github.com";
      };

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
        "https://github.com".helper = "!gh auth git-credential";
        "https://gist.github.com".helper = "!gh auth git-credential";
      };
    };
  };
}
