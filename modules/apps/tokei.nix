{
  den.aspects.apps.provides.tokei = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.tokei ];
      };
  };
}
