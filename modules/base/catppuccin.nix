# https://nix.catppuccin.com/
{ inputs, lib, ... }:
let
  inherit (lib) mkDefault;
  # latte, frappe, macchiato, mocha
  flavor = "frappe";
  accent = "mauve";
in
{
  flake-file.inputs.catppuccin = {
    url = "github:catppuccin/nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.base = {
    nixos =
      { pkgs, ... }:
      {
        imports = [ inputs.catppuccin.nixosModules.catppuccin ];

        environment.systemPackages = [
          # TODO: Don't hardcode
          pkgs.catppuccin-cursors.frappeDark
        ];

        catppuccin = {
          enable = true;
          accent = mkDefault accent;
          flavor = mkDefault flavor;
          cache.enable = true;
          cursors.enable = true;
        };
      };

    darwin = {
    };

    homeManager = {
      imports = [ inputs.catppuccin.homeModules.catppuccin ];

      catppuccin = {
        enable = true;
        accent = mkDefault accent;
        flavor = mkDefault flavor;

        nvim.enable = false;

        # We manage this manually to ensure correct load order
        zsh-syntax-highlighting.enable = false;
      };
    };
  };
}
