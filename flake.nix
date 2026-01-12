{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Linux-specific inputs
    zig-overlay = {
      url = "github:mitchellh/zig-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zls-overlay = {
      url = "github:zigtools/zls";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xremap-flake = {
      url = "github:xremap/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      mkDarwinHome =
        {
          username,
          homeDirectory,
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          modules = [ ./home/darwin.nix ];
          extraSpecialArgs = {
            inherit username homeDirectory;
          };
        };

      mkLinuxHome =
        {
          username,
          homeDirectory,
        }:
        let
          system = "x86_64-linux";
        in
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
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
            ./home/linux.nix
          ];
          extraSpecialArgs = {
            inherit username homeDirectory xremap-flake;
          };
        };
      mkApps =
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          configName =
            if system == "aarch64-darwin" then "ytakhs@darwin" else "ytakhs@linux";
          flakePath = "$HOME/dotfiles";
          hmCmd = "nix run nixpkgs#home-manager --";
        in
        {
          switch = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "switch" ''
                ${hmCmd} switch --flake ${flakePath}#${configName}
              ''
            );
          };
          switch-with-backup = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "switch-with-backup" ''
                ${hmCmd} switch --flake ${flakePath}#${configName} -b backup
              ''
            );
          };
          generations = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "generations" ''
                ${hmCmd} generations --flake ${flakePath}
              ''
            );
          };
          expire = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "expire" ''
                ${hmCmd} expire-generations --flake ${flakePath} "$@"
              ''
            );
          };
          flake-update = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "flake-update" ''
                nix flake update --flake ${flakePath}
              ''
            );
          };
        };
    in
    {
      homeConfigurations = {
        "ytakhs@darwin" = mkDarwinHome {
          username = "ytakhs";
          homeDirectory = /Users/ytakhs;
        };
        "ytakhs@linux" = mkLinuxHome {
          username = "ytakhs";
          homeDirectory = /home/ytakhs;
        };
      };

      apps = {
        aarch64-darwin = mkApps "aarch64-darwin";
        x86_64-linux = mkApps "x86_64-linux";
      };
    };
}
