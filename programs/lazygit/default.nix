{ ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        pager = "delta --paging=never";
      };
    };
  };
}
