{
  den.aspects.apps.provides.codespelunker = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.codespelunker ];
      };
  };
}
