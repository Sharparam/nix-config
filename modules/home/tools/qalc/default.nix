{
  lib,
  pkgs,
  namespace,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.qalc;
in {
  options.${namespace}.tools.qalc = {
    enable = mkEnableOption "qalc";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      libqalculate
    ];
  };
}
