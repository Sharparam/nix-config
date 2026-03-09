{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.system.boot.systemd-boot;
in
{
  options.${namespace}.system.boot.systemd-boot = {
    enable = mkEnableOption "Whether or not to enable systemd-booting.";
  };

  config = mkIf cfg.enable {
    boot.loader = {
      systemd-boot = {
        enable = true;

        configurationLimit = 5;
        editor = false;
      };
      efi.canTouchEfiVariables = true;

      timeout = 5;
    };
  };
}
