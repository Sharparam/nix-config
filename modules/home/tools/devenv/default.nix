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
  cfg = config.${namespace}.tools.devenv;
in
{
  options.${namespace}.tools.devenv = with types; {
    enable = mkEnableOption "devenv";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.devenv
    ];
  };
}
