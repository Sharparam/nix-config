# https://nix.catppuccin.com/
{
  inputs,
  lib,
  ...
}:
let
  inherit (lib) mkDefault;

  # latte, frappe, macchiato, mocha
  flavor = "frappe";
  accent = "mauve";

  flake-file.inputs.catppuccin = {
    url = "github:catppuccin/nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  osAspect =
    { host }:
    {
      nixos =
        { config, pkgs, ... }:
        let
          catppuccin = config.catppuccin;
          cursors = catppuccin.cursors;
          cursors-pkg = pkgs.catppuccin-cursors."${catppuccin.flavor}${lib.toSentenceCase cursors.accent}";
          cursors-name = "catppuccin-${cursors.flavor}-${cursors.accent}-cursors";
        in
        {
          imports = [ inputs.catppuccin.nixosModules.catppuccin ];

          environment.systemPackages = [
            cursors-pkg
          ];

          catppuccin = {
            enable = mkDefault true;
            autoEnable = mkDefault true;
            accent = mkDefault accent;
            flavor = mkDefault flavor;
            cache.enable = mkDefault true;
            cursors = {
              enable = mkDefault true;
              accent = mkDefault "dark";
            };
          };

          services.displayManager.noctalia-greeter = {
            cursorTheme = {
              package = cursors-pkg;
              name = cursors-name;
            };
          };
        };
    };

  hmAspect = {
    homeManager = { config, ... }: {
      imports = [ inputs.catppuccin.homeModules.catppuccin ];

      catppuccin = {
        enable = mkDefault true;
        autoEnable = mkDefault true;
        accent = mkDefault accent;
        flavor = mkDefault flavor;

        cursors = {
          enable = mkDefault true;
          accent = mkDefault "dark";
        };
        nvim.enable = mkDefault false;

        # We manage this manually to ensure correct load order
        zsh-syntax-highlighting.enable = mkDefault false;
      };

      gtk.enable = mkDefault true;

      home = {
        pointerCursor = {
          enable = mkDefault true;
          dotIcons.enable = mkDefault true;
          gtk = {
            enable = mkDefault true;
          };
          x11 = {
            enable = mkDefault true;
          };
        };
      };
    };
  };

  hmUserAspect = { host, user }: hmAspect;

  hmHomeAspect = { home }: hmAspect;

  hmAspects = [
    hmUserAspect
    hmHomeAspect
  ];
in
{
  inherit flake-file;

  den.aspects.catppuccin.includes = [ osAspect ] ++ hmAspects;
}
