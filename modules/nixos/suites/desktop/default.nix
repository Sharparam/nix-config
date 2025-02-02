{
  lib,
  pkgs,
  namespace,
  options,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.suites.desktop;
in
{
  options.${namespace}.suites.desktop = with types; {
    enable = mkEnableOption "Whether or not to enable common desktop configuration.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      desktop = {
        kde = enabled;

        # addons = {
        #   wallpapers = enabled;
        # };
      };

      security = {
        _1password = enabled;
        bitwarden = enabled;
      };

      apps = {
        firefox = enabled;
        # vlc = enabled;
        # yt-music = enabled;
        # gparted = enabled;
      };
    };
  };
}
