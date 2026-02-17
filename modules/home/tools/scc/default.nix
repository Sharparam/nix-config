{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.scc;
in {
  options.${namespace}.tools.scc = {
    enable = mkEnableOption "Enable scc.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      scc
    ];
  };
}
