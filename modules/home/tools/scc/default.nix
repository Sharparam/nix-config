{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.scc;
in
{
  options.${namespace}.tools.scc = {
    enable = mkEnableOption "scc";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.scc
    ];
  };
}
