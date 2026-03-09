{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.hardware.networking;
in
{
  options.${namespace}.hardware.networking = {
    enable = mkEnableOption "networkmanager";
  };

  config = mkIf cfg.enable {
    networking = {
      networkmanager.enable = true;
    };
  };
}
