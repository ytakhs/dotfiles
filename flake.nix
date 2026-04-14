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
    xremap-flake = {
      url = "github:xremap/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nix-darwin,
      xremap-flake,
      llm-agents,
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
            ./home/linux.nix
          ];
          extraSpecialArgs = {
            inherit username homeDirectory xremap-flake;
          };
        };

      mkDarwinHome =
        {
          username,
          homeDirectory,
        }:
        let
          system = "aarch64-darwin";
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ llm-agents.overlays.default ];
            config.allowUnfreePredicate =
              pkg:
              builtins.elem (nixpkgs.lib.getName pkg) [
                "claude-code"
              ];
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home/darwin.nix
          ];
          extraSpecialArgs = {
            inherit username homeDirectory;
          };
        };

      mkDarwinApps =
        let
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          flakePath = "$HOME/dev/ghq/github.com/ytakhs/dotfiles";
          hmCmd = "nix run nixpkgs#home-manager --";
        in
        {
          hm-switch = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "hm-switch" ''
                ${hmCmd} switch --flake ${flakePath}#ytakhs@darwin
              ''
            );
          };
          hm-switch-with-backup = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "hm-switch-with-backup" ''
                ${hmCmd} switch --flake ${flakePath}#ytakhs@darwin -b backup
              ''
            );
          };
          hm-generations = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "hm-generations" ''
                ${hmCmd} generations --flake ${flakePath}
              ''
            );
          };
          hm-expire = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "hm-expire" ''
                ${hmCmd} expire-generations --flake ${flakePath} "-$1 days"
              ''
            );
          };
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
          expire = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "expire" ''
                sudo nix-collect-garbage --delete-older-than "$1d"
              ''
            );
          };
          update = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "update" ''
                nix flake update --flake ${flakePath}
              ''
            );
          };
          update-agents = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "update-agents" ''
                nix flake update llm-agents --flake ${flakePath}
              ''
            );
          };
        };

      mkLinuxApps =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          flakePath = "$HOME/dev/ghq/github.com/ytakhs/dotfiles";
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
                ${hmCmd} expire-generations --flake ${flakePath} "-$1 days"
              ''
            );
          };
          update = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "update" ''
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
          { nixpkgs.overlays = [ llm-agents.overlays.default ]; }
          home-manager.darwinModules.home-manager
          ./darwin/configuration.nix
        ];
      };

      homeConfigurations = {
        "ytakhs@darwin" = mkDarwinHome {
          username = "ytakhs";
          homeDirectory = "/Users/ytakhs";
        };
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
