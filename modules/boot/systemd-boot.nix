{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  den.aspects.boot.provides.systemd-boot = {
    nixos = {
      boot.loader = {
        efi.canTouchEfiVariables = mkDefault true;
        systemd-boot = {
          enable = mkDefault true;
          configurationLimit = mkDefault 5;
          editor = mkDefault false;
        };
        timeout = mkDefault 5;
      };
    };
  };
}
