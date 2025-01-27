{
  description = "Sharparam's Nix files";

  inputs = {
    utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    # stable-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    unstable-darwin.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      # url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-flake = {
      url = "github:snowfallorg/flake";
      inputs.nixpkgs.follows = "unstable";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";

    catppuccin.url = "github:catppuccin/nix";

    iosevka = {
      url = "github:Sharparam/Iosevka/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
            name = "sharparam-nix-dotfiles";
            title = "Sharparam's NixOS/Darwin flake";
          };
        };
      };
    in
    lib.mkFlake {
      inherit inputs;

      src = ./.;

      channels-config = {
        allowUnfree = true;
      };

      overlays = with inputs; [
        snowfall-flake.overlays.default
      ];

      homes.modules = with inputs; [
        nix-index-database.hmModules.nix-index
        sops-nix.homeManagerModules.sops
        catppuccin.homeManagerModules.catppuccin
      ];

      systems.modules = {
        nixos = with inputs; [
          home-manager.nixosModules.home-manager
          nix-index-database.nixosModules.nix-index
          sops-nix.nixosModules.sops
          catppuccin.nixosModules.catppuccin
        ];

        darwin = with inputs; [
          home-manager.darwinModules.home-manager
          nix-index-database.darwinModules.nix-index
          sops-nix.darwinModules.sops
          catppuccin.darwinModules.catppuccin
        ];
      };
    };
}
