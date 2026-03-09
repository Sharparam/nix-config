{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.apps.discord;
in
{
  options.${namespace}.apps.discord = {
    enable = mkEnableOption "Discord";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.vesktop
    ];
  };
}
