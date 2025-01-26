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
  cfg = config.${namespace}.tools.jq;
in
{
  options.${namespace}.tools.jq = with types; {
    enable = mkEnableOption "Whether or not to enable the jq tool.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      jq
    ];
  };
}
