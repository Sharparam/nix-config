{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  den.aspects.base = {
    homeManager =
      { config, ... }:
      let
        inherit (config) sops;
      in
      {
        sops = {
          secrets."radicle/public-key".path = "${config.home.homeDirectory}/.radicle/keys/radicle.pub";
          secrets."radicle/private-key".path = "${config.home.homeDirectory}/.radicle/keys/radicle";
          templates."radicle-node.env".content = ''
            RAD_PASSPHRASE="${sops.placeholder."radicle/passphrase"}"
          '';
        };
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
              connect = [
                "z6MkoGNAbLuAjQoJBSiwvmoGAM9CDp8idGjiABJEBUQyucqs@seed.rad.sharparam.com:8776"
              ];
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
        services.radicle = {
          node = {
            enable = mkDefault true;
            lazy = {
              enable = mkDefault true;
              exitIdleTime = mkDefault "30min";
            };
            args = "--secret '${sops.secrets."radicle/private-key".path}'";
          };
        };
        systemd.user.services."radicle-node" = {
          Service = {
            EnvironmentFile = sops.templates."radicle-node.env".path;
            BindReadOnlyPaths = [
              "${config.xdg.configHome}/sops-nix/secrets/radicle"
            ];
          };
        };
      };
  };
}
