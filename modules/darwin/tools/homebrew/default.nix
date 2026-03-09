{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  cfg = config.${namespace}.tools.homebrew;
in
{
  options.${namespace}.tools.homebrew = {
    enable = mkEnableOption "Whether or not to enable homebrew.";
    enableMas = mkOption {
      type = types.bool;
      default = true;
      description = "Whether or not to enable Mac App Store downloads via homebrew.";
    };
  };

  config = mkIf cfg.enable {
    environment.variables = {
      HOMEBREW_BAT = "1";
      HOMEBREW_NO_ANALYTICS = "1";
      HOMEBREW_NO_INSECURE_REDIRECT = "1";
    };

    environment.systemPackages = mkIf cfg.enableMas [
      pkgs.mas
    ];

    homebrew = {
      enable = true;

      global = {
        autoUpdate = true;
        # brewfile = false;
        # lockfiles = !config.homebrew.global.brewfile;
      };

      onActivation = {
        autoUpdate = false;
        cleanup = "zap";
        upgrade = false;
      };

      taps = [ "homebrew/services" ];
    };
  };
}
