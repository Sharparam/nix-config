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
  cfg = config.${namespace}.fonts;
in
{
  options.${namespace}.fonts = with types; {
    enable = mkEnableOption "Enable home-manager font management.";
  };

  config = mkIf cfg.enable {
    fonts.fontconfig = {
      enable = true;
    };
  };
}
