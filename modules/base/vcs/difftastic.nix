{ lib, ... }:
{
  den.aspects.base = {
    homeManager =
      { config, ... }:
      {
        programs.difftastic = {
          enable = true;
          git = {
            enable = false;
            mode = "both";
          };
          jujutsu.enable = false;
          options = {
            background = "dark";
          };
        };

        programs.jujutsu = {
          settings = {
            merge-tools.difft = {
              program = "difft";
              diff-args = [
                "--color=always"
                "$left"
                "$right"
              ];
            };
          };
        };
      };
  };
}
