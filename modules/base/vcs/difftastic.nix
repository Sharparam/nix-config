{
  den.aspects.base = {
    homeManager = {
      programs.difftastic = {
        enable = true;
        options = {
          background = "dark";
        };
        git = {
          enable = true;
          diffToolMode = true;
        };
      };

      programs.jujutsu = {
        settings = {
          ui = {
            diff-formatter = "difft";
          };
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
