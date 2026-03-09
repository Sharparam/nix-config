{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.jq;
in
{
  options.${namespace}.tools.jq = {
    enable = mkEnableOption "Whether or not to enable the jq tool.";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.jq
    ];
  };
}
