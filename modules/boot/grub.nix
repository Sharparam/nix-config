{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  den.aspects.boot.provides.grub = {
    nixos = {
      boot.loader = {
        efi.canTouchEfiVariables = mkDefault true;
        grub = {
          enable = mkDefault true;
          device = mkDefault "nodev";
          efiSupport = mkDefault true;
          usesOSProber = mkDefault true;
        };
        timeout = mkDefault 5;
      };
    };
  };
}
