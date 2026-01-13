{
  description = "Nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
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
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      zig-overlay,
      zls-overlay,
      xremap-flake,
      ...
    }:
    let
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

      mkDarwinApps =
        let
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          flakePath = "$HOME/dotfiles";
        in
        {
          switch = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "switch" ''
                sudo nix run nix-darwin -- switch --flake ${flakePath}
              ''
            );
          };
          generations = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "generations" ''
                sudo darwin-rebuild --list-generations
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

      mkLinuxApps =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          flakePath = "$HOME/dotfiles";
          hmCmd = "nix run nixpkgs#home-manager --";
        in
        {
          switch = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "switch" ''
                ${hmCmd} switch --flake ${flakePath}#ytakhs@linux
              ''
            );
          };
          switch-with-backup = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "switch-with-backup" ''
                ${hmCmd} switch --flake ${flakePath}#ytakhs@linux -b backup
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
      darwinConfigurations.ytakhs = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          home-manager.darwinModules.home-manager
          ./darwin/configuration.nix
        ];
      };

      homeConfigurations = {
        "ytakhs@linux" = mkLinuxHome {
          username = "ytakhs";
          homeDirectory = /home/ytakhs;
        };
      };

      apps = {
        aarch64-darwin = mkDarwinApps;
        x86_64-linux = mkLinuxApps;
      };
    };
}
