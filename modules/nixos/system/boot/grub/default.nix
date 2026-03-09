{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf mkDefault;
  cfg = config.${namespace}.system.boot.grub;
in
{
  options.${namespace}.system.boot.grub = {
    enable = mkEnableOption "Whether or not to enable grub booting.";
  };

  config = mkIf cfg.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true;

      grub = {
        enable = true;
        device = mkDefault "nodev";
        efiSupport = mkDefault true;
        useOSProber = true;
      };

      timeout = 5;
    };
  };
}
