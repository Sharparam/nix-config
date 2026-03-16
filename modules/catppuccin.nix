# https://nix.catppuccin.com/
{
  inputs,
  lib,
  den,
  ...
}:
let
  inherit (lib) mkDefault;
  inherit (den.lib) take;

  # latte, frappe, macchiato, mocha
  flavor = "frappe";
  accent = "mauve";

  flake-file.inputs.catppuccin = {
    url = "github:catppuccin/nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  osAspect = take.exactly (
    { host }:
    {
      nixos =
        { pkgs, ... }:
        {
          imports = [ inputs.catppuccin.nixosModules.catppuccin ];

          environment.systemPackages = [
            # TODO: Don't hardcode
            pkgs.catppuccin-cursors.frappeDark
          ];

          catppuccin = {
            enable = mkDefault true;
            accent = mkDefault accent;
            flavor = mkDefault flavor;
            cache.enable = mkDefault true;
            cursors.enable = mkDefault true;
          };
        };
    }
  );

  hmAspect = {
    homeManager = {
      imports = [ inputs.catppuccin.homeModules.catppuccin ];

      catppuccin = {
        enable = mkDefault true;
        accent = mkDefault accent;
        flavor = mkDefault flavor;

        nvim.enable = mkDefault false;

        # We manage this manually to ensure correct load order
        zsh-syntax-highlighting.enable = mkDefault false;
      };
    };
  };

  hmUserAspect = take.exactly ({ host, user }: hmAspect);

  hmHomeAspect = take.exactly ({ home }: hmAspect);

  hmAspects = [
    hmUserAspect
    hmHomeAspect
  ];
in
{
  inherit flake-file;

  den.aspects.catppuccin.includes = [ osAspect ] ++ hmAspects;
}
