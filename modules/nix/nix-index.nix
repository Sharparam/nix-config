{ inputs, lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  flake-file.inputs.nix-index-database = {
    url = mkDefault "github:nix-community/nix-index-database";
    inputs.nixpkgs.follows = mkDefault "nixpkgs";
  };

  den.default = {
    nixos = {
      imports = [ inputs.nix-index-database.nixosModules.nix-index ];
    };

    darwin = {
      imports = [ inputs.nix-index-database.darwinModules.nix-index ];
    };

    homeManager = {
      imports = [ inputs.nix-index-database.homeModules.nix-index ];

      programs.nix-index = {
        enable = mkDefault true;
      };
      programs.nix-index-database.comma.enable = mkDefault true;
    };
  };
}
