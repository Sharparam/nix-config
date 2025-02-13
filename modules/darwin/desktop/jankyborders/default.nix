{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.desktop.jankyborders;
in {
  options.${namespace}.desktop.jankyborders = {
    enable = mkEnableOption "Enable janky borders.";
  };

  config = mkIf cfg.enable {
    services.jankyborders = {
      enable = true;
      active_color = "0xffe2e2e3";
      inactive_color = "0xff414550";
      background_color = "0x302c2e34";
      blur_radius = 0.0;
      hidpi = false;
      width = 4.0;
      order = "below";
      style = "round";
    };
  };
}
