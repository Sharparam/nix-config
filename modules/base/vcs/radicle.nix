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
          preferredSeeds = [
            "z6MkoGNAbLuAjQoJBSiwvmoGAM9CDp8idGjiABJEBUQyucqs@seed.rad.sharparam.com:8776"
            "z6MkrLMMsiPWUcNPHcRajuMi9mDfYckSoJyPwwnknocNYPm7@iris.radicle.network:8776"
            "z6MkrLMMsiPWUcNPHcRajuMi9mDfYckSoJyPwwnknocNYPm7@irisradizskwweumpydlj4oammoshkxxjur3ztcmo7cou5emc6s5lfid.onion:8776"
            "z6Mkmqogy2qEM2ummccUthFEaaHvyYmYBYh3dbe9W4ebScxo@rosa.radicle.network:8776"
            "z6Mkmqogy2qEM2ummccUthFEaaHvyYmYBYh3dbe9W4ebScxo@rosarad5bxgdlgjnzzjygnsxrwxmoaj4vn7xinlstwglxvyt64jlnhyd.onion:8776"
            "z6MkuyPDChcwCruKGd2tw54FZo2HemY135JvTLzbVTvoWKJR@index.radicle.garden:8776"
          ];
          publicExplorer = "https://rad.sharparam.com/nodes/$host/$rid$path";
        };
      };
    };
  };
}
