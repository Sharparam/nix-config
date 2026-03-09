{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.desktop.kde;
in
{
  options.${namespace}.desktop.kde = {
    enable = mkEnableOption "Whether or not to use KDE Plasma as the desktop environment.";
  };

  config = mkIf cfg.enable {
    services = {
      xserver.enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma6.enable = true;
    };
  };
}
