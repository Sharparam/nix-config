{
  programs.just = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.just ];
      };
  };
}
