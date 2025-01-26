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
  cfg = config.${namespace}.tools.duf;
in
{
  options.${namespace}.tools.duf = with types; {
    enable = mkEnableOption "Whether or not to enable the duf tool.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      duf
    ];
  };
}
