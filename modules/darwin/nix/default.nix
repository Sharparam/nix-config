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
  cfg = config.${namespace}.nix;
in
{
  options.${namespace}.nix = with types; {
    enable = mkBoolOpt true "Whether or not to manage nix configuration.";
    package = mkOpt package pkgs.lix "Which nix package to use.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # nix-index
      nix-prefetch-git
      nixfmt-rfc-style
      # comma
      snowfallorg.flake
    ];

    services.nix-daemon.enable = true;

    nix =
      let
        users = [
          "root"
          config.${namespace}.user.name
        ];
      in
      {
        package = cfg.package;
        settings = {
          allowed-users = users;
          trusted-users = users;

          experimental-features = "nix-command flakes";
          http-connections = 50;
          log-lines = 50;

          # TODO FIXME
          # Large builds apparently fail due to an issue with darwin:
          # https://github.com/NixOS/nix/issues/4119
          sandbox = false;

          # TODO FIXME
          # This appears to break on darwin
          # https://github.com/NixOS/nix/issues/7273
          auto-optimise-store = false;
        };

        gc = {
          automatic = true;
          interval = {
            Day = 7;
          };
          options = "--delete-older-than 30d";
          user = config.${namespace}.user.name;
        };

        # flake-utils-plus
        generateRegistryFromInputs = true;
        generateNixPathFromInputs = true;
        linkInputs = true;
      };
  };
}
