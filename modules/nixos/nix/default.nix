{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.config.nix;
  user = config.${namespace}.config.user;
in
{
  options.${namespace}.config.nix = with types; {
    enable = mkBoolOpt true "Whether or not to manage nix configuration.";
    package = mkOpt package pkgs.lix "Which nix package to use.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nix-health
      nix-index
      nix-output-monitor
      nix-prefetch-git
      nixfmt-rfc-style
    ];
    nix =
      let
        users = [
          "root"
          user.name
        ];
      in
      {
        package = cfg.package;
        gc = {
          options = "--delete-older-than 30d";
          dates = "daily";
          automatic = true;
        };

        settings = {
          allowed-users = users;
          trusted-users = users;
          sandbox = "relaxed";
          auto-optimise-store = true;
          experimental-features = "nix-command flakes";
          http-connections = 50;
          warn-dirty = false;
          log-lines = 50;
        };
        # flake-utils-plus
        generateRegistryFromInputs = true;
        generateNixPathFromInputs = true;
        linkInputs = true;
      };
  };
}
