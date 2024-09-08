{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "ytakhs";
    userEmail = "21127627+ytakhs@users.noreply.github.com";

    extraConfig = {
      core = {
        pager = "${pkgs.delta}/bin/delta --paging never";
      };

      pager = {
        log = "${pkgs.delta}/bin/delta --paging never | less -+$LESS -R";
        show = "${pkgs.delta}/bin/delta --paging never | less -+$LESS -R";
        diff = "${pkgs.delta}/bin/delta --paging never | less -+$LESS -R";
        blame = "${pkgs.delta}/bin/delta --paging never | less -+$LESS -R";
      };

      init = {
        defaultBranch = "main";
      };
    };
  };
}
