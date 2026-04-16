{ __findFile, ... }:
let
  substituters = [ "https://claude-code.cachix.org" ];
  trusted-public-keys = [ "claude-code.cachix.org-1:YeXf2aNu7UTX8Vwrze0za1WEDS+4DuI2kVeWEE4fsRk=" ];
  nix.settings = {
    inherit substituters trusted-public-keys;
  };

  settings = {
    permissions = {
      allow = [
        "Bash(date:*)"
        "Bash(echo:*)"
        "Bash(cat:*)"
        "Bash(ls:*)"
        # GSD
        # "Bash(mkdir:*)"
        "Bash(wc:*)"
        "Bash(head:*)"
        "Bash(tail:*)"
        "Bash(sort:*)"
        "Bash(grep:*)"
        "Bash(tr:*)"
        # GSD
        # "Bash(git add:*)"
        # "Bash(git commit:*)"
        # "Bash(git status:*)"
        # "Bash(git log:*)"
        # "Bash(git diff:*)"
        # "Bash(git tag:*)"
      ];

      deny = [
        "Read(.env)"
        "Read(.env.*)"
        "Read(**/secrets/*)"
        "Read(**/*credential*)"
        "Read(**/*.age)"
        "Read(**/*.pem)"
        "Read(**/*.key)"
      ];
    };
    statusLine = {
      type = "command";
      command = "bash ${./statusline-command.sh}";
    };
  };
in
{
  programs.ai.provides.claude = {
    includes = [ (<den/unfree> [ "claude-code-bin" ]) ];

    os = {
      inherit nix;
    };

    darwin = {
      homebrew.casks = [ "claude" ];
    };

    homeManager =
      { pkgs, ... }:
      let
        jsonFormat = pkgs.formats.json { };
      in
      {
        inherit nix;

        home.file.".claude/settings.json".source = jsonFormat.generate "claude-settings.json" settings;

        programs.claude-code = {
          enable = true;
          package = pkgs.claude-code-bin;
        };
      };
  };
}
