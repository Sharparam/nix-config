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
  user = config.${namespace}.user;
in
{
  options.${namespace}.nix = with types; {
    enable = mkBoolOpt true "Whether or not to manage nix configuration.";
    package = mkOpt package pkgs.lix "Which nix package to use.";
    flakePath =
      mkOpt str "/home/${user.name}/repos/github.com/Sharparam/nix-config"
        "Path to the flake to use for NixOS configuration.";
    keepAge = mkOpt str "30d" "How old to allow store paths to be before deleting them.";
    keepCount = mkOpt int 3 "How many store paths to keep.";
    # cleanAge = mkOpt str "30d" "How old to allow store paths to be before deleting them.";
  };

  config = mkIf cfg.enable {
    documentation = {
      doc.enable = false;
      info.enable = false;
      man.enable = mkDefault true;
    };

    environment.systemPackages = with pkgs; [
      nix-health
      # nix-index
      nix-output-monitor
      nix-prefetch-git
      nixfmt-rfc-style
      # comma
      snowfallorg.flake
    ];

    programs = {
      nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since ${cfg.keepAge} --keep ${toString cfg.keepCount}";
        flake = cfg.flakePath;
      };
    };

    nix =
      let
        users = [
          "root"
          user.name
        ];
      in
      {
        package = cfg.package;
        # gc = {
        #   options = "--delete-older-than ${cfg.cleanAge}";
        #   dates = "daily";
        #   automatic = true;
        # };

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
