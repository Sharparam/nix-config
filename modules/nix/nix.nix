{
  flake-file.inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  den.default = {
    os =
      { lib, pkgs, ... }:
      {
        environment.systemPackages = builtins.attrValues {
          inherit (pkgs)
            nix-diff
            nix-health
            # nix-index
            nix-output-monitor
            nix-prefetch-git
            nixd
            nixfmt
            nurl
            nvd
            # comma
            cachix
            alejandra
            deadnix
            statix
            ;
        };

        nix = {
          settings = {
            allowed-users = [ "@wheel" ];
            trusted-users = [ "@wheel" ];
            auto-optimise-store = true;
            experimental-features = [
              "nix-command"
              "flakes"
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
  };
}
