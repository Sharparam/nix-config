{ lib, ... }:
{
  den.default = {
    nixos = {
      # Set your time zone.
      time.timeZone = lib.mkDefault "Europe/Stockholm";
    };
  };
}
