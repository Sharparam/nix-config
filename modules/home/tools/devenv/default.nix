{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.devenv;
in
{
  options.${namespace}.tools.devenv = {
    enable = mkEnableOption "devenv";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.devenv
    ];
  };
}
