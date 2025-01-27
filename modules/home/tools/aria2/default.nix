{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.aria2;
in
{
  options.${namespace}.tools.aria2 = {
    enable = mkEnableOption "aria2";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      aria2
    ];
  };
}
