{
  den.aspects.base = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.aria2 ];
      };
  };
}
