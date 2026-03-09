{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.security.sudo;
in
{
  options.${namespace}.security.sudo = {
    enable = mkEnableOption "Whether or not to enable the sudo security module.";
  };

  config = mkIf cfg.enable {
    security.pam.services.sudo_local.touchIdAuth = true;
  };
}
