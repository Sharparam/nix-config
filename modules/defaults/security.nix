{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  den.default = {
    nixos = {
      security.pam.u2f = {
        settings = {
          cue = mkDefault true;
        };
      };
    };
  };
}
