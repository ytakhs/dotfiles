{
  description = "Home Manager configuration of ytakhs";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # https://github.com/mitchellh/zig-overlay
    zig-overlay.url = "github:mitchellh/zig-overlay";
    zig-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      zig-overlay,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      sandboxUser = builtins.getEnv "DOTFILES_SANDBOX_USERNAME";
      sandboxHomeDir = builtins.getEnv "DOTFILES_SANDBOX_HOMEDIR";

      mkConfig =
        {
          username,
          homeDirectory,
        }:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            (
              { config, pkgs, ... }:
              {
                nixpkgs.overlays = [ zig-overlay.overlays.default ];
              }
            )
            ../../home.nix
          ];

          extraSpecialArgs = {
            homeDirectory = homeDirectory;
            username = username;
          };
        };
    in
    {
      homeConfigurations.ytakhs = mkConfig {
        username = "ytakhs";
        homeDirectory = /home/ytakhs;
      };
      homeConfigurations.${sandboxUser} = mkConfig {
        username = sandboxUser;
        homeDirectory = sandboxHomeDir;
      };
    };
}
