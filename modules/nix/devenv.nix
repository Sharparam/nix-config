let
  substituters = [ "https://devenv.cachix.org" ];
  trusted-public-keys = [ "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=" ];
  nix.settings = {
    inherit substituters trusted-public-keys;
  };
in
{
  den.default = {
    os = {
      inherit nix;
    };

    homeManager =
      { pkgs, ... }:
      {
        inherit nix;

        home.packages = [ pkgs.devenv ];
      };
  };
}
