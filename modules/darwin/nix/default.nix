{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.nix;
in {
  options.${namespace}.nix = with types; {
    enable = mkBoolOpt true "Whether or not to manage nix configuration.";
    package = mkOpt package pkgs.lix "Which nix package to use.";
  };

  config = mkIf cfg.enable {
    documentation = {
      doc.enable = false;
      info.enable = false;
      man.enable = mkDefault true;
    };

    environment.systemPackages = with pkgs; [
      nix-diff
      nix-health
      # nix-index
      nix-output-monitor
      nix-prefetch-git
      nixd
      nixfmt-rfc-style
      nvd
      # comma
      cachix
      snowfallorg.flake
      alejandra
      deadnix
      statix
    ];

    services = {
      lorri = enabled;
      nix-daemon = enabled;
    };

    nix = let
      users = [
        "root"
        config.${namespace}.user.name
      ];
    in {
      package = cfg.package;
      settings = {
        allowed-users = users;
        trusted-users = users;

        experimental-features = "nix-command flakes";
        # TODO: Broken on nix-darwin
        # See: https://github.com/LnL7/nix-darwin/issues/943
        # See: https://github.com/LnL7/nix-darwin/issues/947
        # use-xdg-base-directories = true;
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

        substituters = [
          "https://nix-community.cachix.org"
        ];

        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
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
