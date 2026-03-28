{
  programs.glow = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.glow ];
      };
  };
}
