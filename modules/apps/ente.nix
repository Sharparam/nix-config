{ lib, ... }:
{
  den.aspects.apps.provides.ente = {
    darwin = {
      homebrew.casks = [ "ente" ];
    };

    homeManager =
      { pkgs, ... }:
      let
        inherit (pkgs.stdenv.hostPlatform) isLinux;
      in
      {
        home.packages = [
          pkgs.ente-cli
        ]
        ++ lib.optionals isLinux [ pkgs.ente-desktop ];
      };
  };
}
