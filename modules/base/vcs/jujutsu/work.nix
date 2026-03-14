{
  den.aspects.base = {
    homeManager =
      { pkgs, ... }:
      {
        xdg.configFile."jj/conf.d/10-work.toml".source =
          let
            tomlFormat = pkgs.formats.toml { };
          in
          tomlFormat.generate "work.toml" {
            "--when".repositories = [
              "~/projects/work/ninetech/"
              "~/projects/serveit/"
              "~/projects/toolpal/"
              "~/projects/plendo/"
              "~/repos/ssh.dev.azure.com/v3/ToolPal/"
            ];
            user = {
              name = "Adam Hellberg";
              email = "adam.hellberg@ninetech.com";
            };
            templates = {
              git_push_bookmark = ''"adam/push-" ++ change_id.short()'';
            };
          };
      };
  };
}
