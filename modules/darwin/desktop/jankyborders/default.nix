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
  cfg = config.${namespace}.desktop.jankyborders;
in
{
  options.${namespace}.desktop.jankyborders = {
    enable = mkEnableOption "Enable janky borders.";
  };

  config = mkIf cfg.enable {
    services.jankyborders = {
      enable = true;
      active_color = "0xff7793d1";
      inactive_color = "0xff5e6798";
      background_color = "0x302c2e34";
      blur_radius = 25.0;
      hidpi = false;
      width = 5.0;
    };
  };
}
