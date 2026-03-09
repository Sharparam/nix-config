{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.suites.desktop;
in
{
  options.${namespace}.suites.desktop = {
    enable = mkEnableOption "Whether or not to enable common desktop configuration.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      desktop = {
        kde.enable = true;

        # addons = {
        #   wallpapers.enable = true;
        # };
      };

      security = {
        _1password.enable = true;
        bitwarden.enable = true;
      };

      apps = {
        # vlc.enable = true;
        # yt-music.enable = true;
        # gparted.enable = true;
      };
    };
  };
}
