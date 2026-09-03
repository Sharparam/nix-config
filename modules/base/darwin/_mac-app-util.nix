{
  inputs,
  lib,
  ...
}:
let
  flake-file.inputs.mac-app-util = {
    url = lib.mkDefault "github:hraban/mac-app-util";
    inputs = {
      # nixpkgs.follows = lib.mkDefault "nixpkgs";
      # systems.follows = lib.mkDefault "systems";
      # treefmt-nix.follows = lib.mkDefault "treefmt-nix";
      # cl-nix-lite.follows = lib.mkDefault "cl-nix-lite";
    };
  };
  # flake-file.inputs.cl-nix-lite = {
  #   url = lib.mkDefault "github:hraban/cl-nix-lite";
  #   inputs = {
  #     nixpkgs.follows = lib.mkDefault "nixpkgs";
  #     systems.follows = lib.mkDefault "systems";
  #     treefmt-nix.follows = lib.mkDefault "treefmt-nix";
  #   };
  # };

  darwinAspect =
    { host }:
    {
      darwin = {
        imports = [
          inputs.mac-app-util.darwinModules.default
        ];
      };
    };

  hmAspect = {
    homeManager = {
      imports = [
        inputs.mac-app-util.homeManagerModules.default
      ];
    };
  };

  homeUserAspect = { host, user }: hmAspect;
  homeAspect = { home }: hmAspect;
in
{
  inherit flake-file;

  den.aspects.base = {
    provides.host.includes = [ darwinAspect ];
    provides.user.includes = [ homeUserAspect ];
    provides.home.includes = [ homeAspect ];
  };
}
