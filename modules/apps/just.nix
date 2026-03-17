{
  den.aspects.apps.provides.just = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.just ];
      };
  };
}
