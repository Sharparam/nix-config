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

      apps = {
        # _1password = enabled;
        firefox = enabled;
        # vlc = enabled;
        # yt-music = enabled;
        # gparted = enabled;
      };
    };
  };
}
