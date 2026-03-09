{
  description = "Sharparam's Nix files";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    # stable-darwin.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # unstable-darwin.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      # url = "github:nix-community/home-manager";
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-flake = {
      url = "github:snowfallorg/flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";

    treefmt-nix.url = "github:numtide/treefmt-nix";

    catppuccin = {
      url = "github:catppuccin/nix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    iosevka = {
      url = "github:Sharparam/Iosevka/v1.0.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    locale-en_se = {
      url = "github:Sharparam/locale-en_se/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-app-util.url = "github:hraban/mac-app-util";

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty.url = "github:ghostty-org/ghostty";
  };

  outputs =
    inputs:
    let
      lib = inputs.snowfall-lib.mkLib {
        inherit inputs;

        src = ./.;

        snowfall = {
          namespace = "snix";
          meta = {
            name = "snix";
            title = "Sharparam's NixOS/nix-darwin/nix flake";
          };
        };
      };
    in
    lib.mkFlake {
      channels-config = {
        allowUnfree = true;
      };

      overlays = [
        inputs.snowfall-flake.overlays.default
        inputs.nur.overlays.default
        inputs.emacs-overlay.overlays.default
        inputs.ghostty.overlays.default
      ];

      homes.modules = [
        inputs.nix-index-database.homeModules.nix-index
        inputs.sops-nix.homeManagerModules.sops
        inputs.catppuccin.homeModules.catppuccin
      ];

      homes.users."sharparam@NINETECH-617128".modules = [
        inputs.mac-app-util.homeManagerModules.default
      ];

      systems.modules = {
        nixos = [
          inputs.home-manager.nixosModules.home-manager
          inputs.nix-index-database.nixosModules.nix-index
          inputs.nur.modules.nixos.default
          inputs.sops-nix.nixosModules.sops
          inputs.catppuccin.nixosModules.catppuccin
          inputs.locale-en_se.nixosModules.default
        ];

        darwin = [
          inputs.home-manager.darwinModules.home-manager
          inputs.nix-index-database.darwinModules.nix-index
          inputs.sops-nix.darwinModules.sops
          inputs.mac-app-util.darwinModules.default
        ];
      };

      alias = {
        packages = {
          default = "scripts";
        };

        shells = {
          default = "dev";
        };
      };

      outputs-builder = channels: {
        formatter = inputs.treefmt-nix.lib.mkWrapper channels.nixpkgs ./treefmt.nix;
      };
    };
}
