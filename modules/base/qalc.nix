{
  den.aspects.base = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.libqalculate ];
      };
  };
}
