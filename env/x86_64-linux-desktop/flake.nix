{
  description = "Home Manager configuration";

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
    zls-overlay.url = "github:zigtools/zls";
    zls-overlay.inputs.nixpkgs.follows = "nixpkgs";
    xremap-flake.url = "github:xremap/nix-flake";
    xremap-flake.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      zig-overlay,
      zls-overlay,
      xremap-flake,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      dynamicUser = builtins.getEnv "DOTFILES_DYNAMIC_USERNAME";
      dynamicHomeDir = builtins.getEnv "DOTFILES_DYNAMIC_HOMEDIR";

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
                nixpkgs.overlays = [
                  (
                    final: prev:
                    let
                      zig = zig-overlay.packages.${system}.master;
                      zls = zls-overlay.packages.${system}.zls.overrideAttrs {
                        nativeBuildInputs = [ zig ];
                      };
                    in
                    {
                      inherit zig zls;
                    }
                  )
                ];
              }
            )
            ./home.nix
          ];

          extraSpecialArgs = {
            homeDirectory = homeDirectory;
            username = username;
            inherit xremap-flake;
          };
        };
    in
    {
      homeConfigurations.ytakhs = mkConfig {
        username = "ytakhs";
        homeDirectory = /home/ytakhs;
      };
      homeConfigurations.${dynamicUser} = mkConfig {
        username = dynamicUser;
        homeDirectory = dynamicHomeDir;
      };
    };
}
