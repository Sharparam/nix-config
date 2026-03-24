{ lib, ... }:
{
  den.aspects.apps.provides.filen = {
    darwin = {
      homebrew.casks = [
        "filen"
      ];
    };

    homeManager =
      { pkgs, ... }:
      let
        inherit (pkgs.stdenv.hostPlatform) isLinux;
      in
      {
        home.packages = [
          pkgs.local.filen-cli
        ]
        ++ lib.optionals isLinux [ pkgs.filen-desktop ];
      };
  };
}
