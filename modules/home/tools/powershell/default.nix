{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.powershell;
in
{
  options.${namespace}.tools.powershell = {
    enable = mkEnableOption "PowerShell";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.powershell
    ];
  };
}
