{ lib, ... }:
{
  den.aspects.base.nixos =
    { pkgs, ... }:
    {
      services.xserver = {
        enable = lib.mkDefault false;
        excludePackages = lib.mkDefault [ pkgs.xterm ];
      };
    };
}
