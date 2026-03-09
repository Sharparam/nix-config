{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.apps.jetbrains.rider;
in
{
  options.${namespace}.apps.jetbrains.rider = {
    enable = mkEnableOption "JetBrains Rider IDE";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.jetbrains.rider
    ];
  };
}
