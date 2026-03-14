{
  den.aspects.base = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.rsync ];

        home.shellAliases = {
          rsync = "rsync --info=progress2 --partial -h";
        };
      };
  };
}
