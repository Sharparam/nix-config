{
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.home-manager;
in
{
  options.${namespace}.tools.home-manager = {
    enable = mkEnableOption "home-manager";
  };

  config = mkIf cfg.enable { programs.home-manager.enable = true; };
}
