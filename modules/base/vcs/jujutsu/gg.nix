{ lib, ... }:
{
  den.aspects.base = {
    darwin = {
      homebrew.casks = [ "gg" ];
    };

    homeManager =
      { pkgs, ... }:
      let
        isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
      in
      {
        home.packages = lib.mkIf (!isDarwin) [ pkgs.gg-jj ];
      };
  };
}
