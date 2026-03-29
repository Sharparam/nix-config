{
  programs.helix = {
    homeManager = {
      home.shellAliases.helix = "hx";
      programs.helix = {
        enable = true;
        settings = {
          editor = {
            color-modes = true;
            cursorline = true;
            idle-timeout = 500;
            line-number = "relative";
            rulers = [
              80
              120
            ];
            cursor-shape = {
              normal = "block";
              insert = "bar";
              select = "block";
            };
            whitespace = {
              render = {
                space = "all";
                tab = "all";
                newline = "none";
              };
              characters = {
                nbsp = "⍽";
              };
            };
          };
        };
      };
    };
  };
}
