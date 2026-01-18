{
  config,
  pkgs,
  lib,
  ...
}:

let
  username = "ytakhs";
  homeDirectory = "/Users/${username}";
in
{
  # Nix configuration (managed by Determinate Nix installer)
  nix.enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "claude-code"
    ];

  # Homebrew
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    brews = [ ];
    casks = [
      "1password"
      "claude"
      "google-chrome"
      "google-drive"
      "ghostty"
      "karabiner-elements"
      "obsidian"
      "raycast"
    ];
  };

  # Fonts
  fonts.packages = with pkgs; [
    udev-gothic
    udev-gothic-nf
  ];

  # System configuration
  system.stateVersion = 6;
  system.primaryUser = username;

  # Home Manager integration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = import ../home/darwin.nix;
    extraSpecialArgs = {
      inherit username homeDirectory;
    };
  };

  # User configuration
  users.users.${username} = {
    name = username;
    home = homeDirectory;
  };
}
