{
  programs.tokei = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.tokei ];
      };
  };
}
