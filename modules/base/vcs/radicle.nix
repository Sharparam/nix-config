{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  den.aspects.base = {
    homeManager = {
      programs.radicle = {
        enable = mkDefault true;
        uri = {
          rad = {
            browser = {
              preferredNode = mkDefault "seed.rad.sharparam.com";
            };
          };
        };
        settings = {
          node = {
            seedingPolicy = {
              default = mkDefault "block";
            };
          };
        };
      };
    };
  };
}
