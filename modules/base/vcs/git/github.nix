{ __findFile, ... }:
let
  githubUsername = "Sharparam";
  sessionVariables = {
    GITHUB_USER = githubUsername;
  };
in
{
  den.aspects.base = {
    includes = [
      (<den/unfree> [ "github-copilot-cli" ])
    ];

    homeManager =
      { pkgs, ... }:
      {
        home.sessionVariables = sessionVariables;
        systemd.user.sessionVariables = sessionVariables;

        home.packages = [
          pkgs.gh
          pkgs.github-copilot-cli
        ];

        programs = {
          zsh.sessionVariables = sessionVariables;

          git.settings = {
            github = {
              user = githubUsername;
              username = githubUsername;
            };
            hub.protocol = "ssh";
            url = {
              "git@github.com:Sharparam".insteadOf = "https://github.com/Sharparam";
              "git@github.com:SharpWoW".insteadOf = "https://github.com/SharpWoW";
              "git@github.com:chroma-sdk".insteadOf = "https://github.com/chroma-sdk";
              "ssh://git@github.com".pushInsteadOf = "https://github.com";
            };
          };
        };

        home.shellAliases =
          let
            gh = "gh";
          in
          {
            "?" = "${gh} copilot suggest -t shell";
            "??" = "${gh} copilot explain";
            "?e" = "${gh} copilot explain";
            "?g" = "${gh} copilot suggest -t git";
            "?gh" = "${gh} copilot suggest -t gh";
          };
      };
  };
}
