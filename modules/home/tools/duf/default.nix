{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.duf;
in
{
  options.${namespace}.tools.duf = {
    enable = mkEnableOption "Whether or not to enable the duf tool.";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.duf
    ];
  };
}
