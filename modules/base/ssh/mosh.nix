{
  den.aspects.ssh = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.mosh ];
      };
  };
}
