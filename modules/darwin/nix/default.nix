{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib)
    mkIf
    mkOption
    mkPackageOption
    mkDefault
    types
    ;
  cfg = config.${namespace}.nix;
  inherit (config.${namespace}) user;
in
{
  options.${namespace}.nix =
    let
      inherit (types) int str;
    in
    {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Whether or not to manage nix configuration.";
      };
      package = mkPackageOption pkgs "Lix" {
        default = [
          "lixPackageSets"
          "latest"
          "lix"
        ];
      };
      flakePath = mkOption {
        type = str;
        default = "/Users/${user.name}/repos/github.com/Sharparam/nix-config?submodules=1";
        description = "Path to the flake to use for NixOS configuration.";
      };
    };

  config = mkIf cfg.enable {
    documentation = {
      doc.enable = false;
      info.enable = false;
      man.enable = mkDefault true;
    };

    # There is no `programs.nh` in nix-darwin so we set the NH_FLAKE env var manually
    environment.variables = {
      NH_FLAKE = cfg.flakePath;
    };

    environment.systemPackages = builtins.attrValues {
      inherit (pkgs)
        nh
        nix-diff
        nix-health
        # nix-index
        nix-output-monitor
        nix-prefetch-git
        nixd
        nixfmt
        nvd
        # comma
        cachix
        alejandra
        deadnix
        statix
        ;
      inherit (pkgs.snowfallorg)
        flake
        ;
    };

    services = {
      lorri.enable = true;
      # Nix daemon is now managed automatically when nix-darwin is enabled
      # nix-daemon.enable = true;
    };

    nix =
      let
        users = [
          "root"
          config.${namespace}.user.name
        ];
      in
      {
        inherit (cfg) package;
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
          # no longer has any effect
          # user = config.${namespace}.user.name;
        };

        # flake-utils-plus
        generateRegistryFromInputs = true;
        generateNixPathFromInputs = true;
        linkInputs = true;
      };
  };
}
