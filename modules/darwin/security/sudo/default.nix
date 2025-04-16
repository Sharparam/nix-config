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
  cfg = config.${namespace}.security.sudo;
in
{
  options.${namespace}.security.sudo = with types; {
    enable = mkEnableOption "Whether or not to enable the sudo security module.";
  };

  config = mkIf cfg.enable {
    security.pam.services.sudo_local.touchIdAuth = true;
  };
}
