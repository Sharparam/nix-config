{
  den.aspects.base = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.yt-dlp ];
      };
  };
}
