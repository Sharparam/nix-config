{ lib, ... }:
{
  flake-file.inputs.home-manager = {
    url = lib.mkDefault "github:nix-community/home-manager";
    inputs.nixpkgs.follows = lib.mkDefault "nixpkgs";
  };

  den.schema.user.classes = lib.mkDefault [ "homeManager" ];

  den.default = {
    os = {
      home-manager.useUserPackages = true;
      home-manager.useGlobalPkgs = true;
    };

    homeManager = {
      programs.home-manager.enable = true;
      xdg.enable = true;
    };
  };
}
