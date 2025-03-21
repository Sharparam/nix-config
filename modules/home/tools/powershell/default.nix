{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.powershell;
in {
  options.${namespace}.tools.powershell = with types; {
    enable = mkEnableOption "PowerShell";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      powershell
    ];
  };
}
