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
  cfg = config.${namespace}.tools.homebrew;
in
{
  options.${namespace}.tools.homebrew = with types; {
    enable = mkEnableOption "Whether or not to enable homebrew.";
    enableMas = mkBoolOpt true "Whether or not to enable Mac App Store downloads via homebrew.";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      HOMEBREW_BAT = "1";
      HOMEBREW_NO_ANALYTICS = "1";
      HOMEBREW_NO_INSECURE_REDIRECT = "1";
    };

    environment.systemPackages =
      with pkgs;
      mkIf cfg.enableMas [
        mas
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
    };
  };
}
