{ lib, ... }:
{
  den.aspects.base = {
    homeManager =
      { config, ... }:
      let
        cfg = config.programs.delta;
      in
      {
        programs.delta = {
          enable = true;
          enableGitIntegration = true;
          enableJujutsuIntegration = true;
          options = {
            features = lib.mkForce "catppuccin-${config.catppuccin.flavor} zebra-dark";
            hyperlinks = true;
            line-numbers = true;
            navigate = true;
          };
        };

        programs.git =
          let
            deltaCmd = lib.getExe cfg.package;
          in
          {
            settings = {
              difftool.delta.cmd = "${deltaCmd} $LOCAL $REMOTE";
            };
          };
      };
  };
}
