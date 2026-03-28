{
  programs.codespelunker = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.codespelunker ];
      };
  };
}
