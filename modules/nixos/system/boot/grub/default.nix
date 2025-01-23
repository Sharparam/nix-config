{
  lib,
  pkgs,
  namespace,
  options,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.system.boot.grub;
in
{
  options.${namespace}.system.boot.grub = with types; {
    enable = mkEnableOption "Whether or not to enable grub booting.";
  };

  config = mkIf cfg.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true;

      grub = {
        enable = true;
        device = mkDefault "nodev";
        efiSupport = true;
        useOSProber = true;
      };

      timeout = 5;
    };
  };
}
