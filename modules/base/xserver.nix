{ lib, ... }:
{
  den.aspects.base.nixos =
    { pkgs, ... }:
    {
      services.xserver = {
        enable = lib.mkDefault true;
        excludePackages = lib.mkDefault [ pkgs.xterm ];
      };
    };
}
