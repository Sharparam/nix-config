{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.system.xkb.eu;
in
{
  options.${namespace}.system.xkb.eu = {
    enable = mkEnableOption "${namespace}.config.xkb.eu.enable";
  };

  config = mkIf cfg.enable {
    console.useXkbConfig = true;
    services.xserver.xkb = {
      layout = "eu";
      # variant = "altgr-intl";
      options = "caps:escape_shifted_compose,compose:rwin";
    };
  };
}
