{ ... }:
{
  programs.starship = {
    enable = true;

    settings = {
      add_newline = true;
      format = "[#](blue bold) $directory$all";

      directory = {
        truncation_length = 2;
        truncate_to_repo = false;
        truncation_symbol = "../";
      };

      os.format = "\\[[$symbol]($style)\\]";
      sudo.format = "\\[[as $symbol]($style)\\]";
      time.format = "\\[[$time]($style)\\]";
      username.format = "\\[[$user]($style)\\]";
      memory_usage.format = "\\[$symbol[$ram( | $swap)]($style)\\]";
      cmd_duration.format = "\\[[⏱ $duration]($style)\\]";
      package.format = "\\[[$symbol$version]($style)\\]";

      # languages
      bun.format = "\\[[$symbol($version)]($style)\\]";
      c.format = "\\[[$symbol($version(-$name))]($style)\\]";
      deno.format = "\\[[$symbol($version)]($style)\\]";
      elixir.format = "\\[[$symbol($version \(OTP $otp_version\))]($style)\\]";
      erlang.format = "\\[[$symbol($version)]($style)\\]";
      golang.format = "\\[[$symbol($version)]($style)\\]";
      nix_shell.format = "\\[[$symbol$state( \\($name\\))]($style)\\]";
      nodejs.format = "\\[[$symbol($version)]($style)\\]";
      python.format = "\\[[$symbol$pyenv_prefix($version)(\\($virtualenv\\))]($style)\\]";
      ruby.format = "\\[[$symbol($version)]($style)\\]";
      rust.format = "\\[[$symbol($version)]($style)\\]";
      zig.format = "\\[[$symbol($version)]($style)\\]";

      # tools
      docker_context.format = "\\[[$symbol$context]($style)\\]";
      git_branch.format = "\\[[$symbol$branch]($style)\\]";
      git_status.format = "([\\[$all_status$ahead_behind\\]]($style))";
      kubernetes.format = "\\[[$symbol$context( \($namespace\))]($style)\\]";
      terraform.format = "\\[[$symbol$workspace]($style)\\]";
    };
  };
}
