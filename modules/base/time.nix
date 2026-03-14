{ lib, ... }:
{
  den.aspects.base = {
    nixos = {
      time.timeZone = lib.mkDefault "Europe/Stockholm";
    };
  };
}
