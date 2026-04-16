let
  packages =
    pkgs:
    builtins.attrValues {
      inherit (pkgs)
        alejandra
        cachix
        deadnix
        nix-diff
        nix-health
        nix-output-monitor
        nix-prefetch-git
        nixd
        nixfmt
        nixpkgs-review
        nurl
        nvd
        statix
        ;
    };
in
{
  flake-file.inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  den.default = {
    includes = [
      (
        { home }:
        {
          homeManager =
            { pkgs, ... }:
            {
              home.packages = packages pkgs;
            };
        }
      )
    ];
    os =
      { lib, pkgs, ... }:
      {
        environment.systemPackages = packages pkgs;

        nix = {
          settings = {
            allowed-users = [ "@wheel" ];
            trusted-users = [ "@wheel" ];
            auto-optimise-store = true;
            experimental-features = [
              "nix-command"
              "flakes"
              "pipe-operator"
            ];
            http-connections = 50;
            log-lines = 50;
            warn-dirty = false;
            sandbox = "relaxed";
          };
          gc = {
            automatic = lib.mkDefault true;
          };
        };
      };

    nixos = {
      nix = {
        settings = {
          use-xdg-base-directories = true;
        };
      };
    };

    darwin = {
      nix = {
        settings = {
          # TODO: Broken on nix-darwin
          # See: https://github.com/LnL7/nix-darwin/issues/943
          # See: https://github.com/LnL7/nix-darwin/issues/947
          use-xdg-base-directories = false;
        };
      };
    };

    homeManager =
      { config, ... }:
      {
        nix = {
          extraOptions = ''
            !include ${config.sops.secrets.nix-access-tokens.path}
          '';
        };

        sops.secrets.nix-access-tokens = {
          mode = "0400";
        };
      };
  };
}
