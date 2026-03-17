{
  den.aspects.base = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [
          pkgs.ghq
        ];

        programs.git.settings.ghq = {
          root = "~/repos";
        };
      };
  };
}
