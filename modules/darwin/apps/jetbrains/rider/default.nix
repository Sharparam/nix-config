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
  cfg = config.${namespace}.apps.jetbrains.rider;
in
{
  options.${namespace}.apps.jetbrains.rider = with types; {
    enable = mkEnableOption "JetBrains Rider IDE";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      jetbrains.rider
    ];
  };
}
