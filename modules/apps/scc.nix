{
  den.aspects.apps.provides.scc = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.scc ];
      };
  };
}
