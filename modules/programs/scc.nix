{
  programs.scc = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.scc ];
      };
  };
}
