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
      active_color = "0xffbabbf1"; # Catppuccin Frappé - Lavender
      inactive_color = "0xff737994"; # Catpuccin Frappé - Overlay 0
      background_color = "0x30303446"; # Catppuccin Frappé - Base
      blur_radius = 0.0;
      hidpi = false;
      width = 4.0;
      order = "below";
      style = "round";
    };
  };
}
