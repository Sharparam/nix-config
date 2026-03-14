{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  den.aspects.desktops.provides.kde = {
    nixos = {
      services = {
        xserver.enable = mkDefault true;
        displayManager.sddm.enable = mkDefault true;
        desktopManager.plasma6.enable = mkDefault true;
      };
    };
  };
}
