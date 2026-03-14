{
  inputs,
  lib,
  withSystem,
  ...
}:
{
  # Does not have a nixpkgs input
  flake-file.inputs.pkgs-by-name-for-flake-parts.url = lib.mkDefault "github:drupol/pkgs-by-name-for-flake-parts";

  imports = [
    inputs.pkgs-by-name-for-flake-parts.flakeModule
  ];

  perSystem =
    { config, system, ... }:
    {
      # _module.args.pkgs = import inputs.nixpkgs {
      #   inherit system;
      #   overlays = [
      #     (final: prev: {
      #       local = config.packages;
      #     })
      #   ];
      #   # overlays = [ inputs.self.overlays.default ];
      # };

      pkgsDirectory = ../pkgs/by-name;
    };

  flake = {
    overlays.default =
      _final: prev:
      withSystem prev.stdenv.hostPlatform.system (
        { config, ... }:
        {
          local = config.packages;
        }
      );
  };

  den.default = {
    nixos = {
      nixpkgs.overlays = [
        inputs.self.overlays.default
      ];
    };
  };
}
