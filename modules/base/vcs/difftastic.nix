{ lib, ... }:
{
  den.aspects.base = {
    homeManager =
      { config, ... }:
      let
        cfg = config.programs.difftastic;
      in
      {
        programs.difftastic = {
          enable = true;
          git = {
            enable = false;
            diffToolMode = true;
          };
          jujutsu.enable = false;
          options = {
            background = "dark";
          };
        };

        programs.git =
          let
            difft = "${lib.getExe cfg.package} ${lib.cli.toCommandLineShellGNU { } cfg.options}";
          in
          {
            settings = lib.mkIf (cfg.enable && !cfg.git.enable && cfg.git.diffToolMode) {
              difftool.difftastic.cmd = "${difft} $LOCAL $REMOTE";
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
