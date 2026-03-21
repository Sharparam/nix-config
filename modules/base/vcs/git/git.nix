let
  ninetechConfig = {
    user = {
      name = "Adam Hellberg";
      email = "adam.hellberg@ninetech.com";
    };
  };
in
{
  den.aspects.base = {
    homeManager =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      let
        inherit (pkgs.stdenv) isLinux;
      in
      {
        programs = {
          git = {
            enable = true;
            lfs.enable = true;
            signing = {
              signByDefault = true;
            };
            settings = {
              user = {
                name = "Adam Hellberg";
                email = "sharparam@sharparam.com";
              };
              core = {
                autocrlf = "input";
              };
              column.ui = "auto";
              init.defaultBranch = "main";
              commit.verbose = true;
              rebase = {
                autoSquash = true;
                autoStash = true;
                updateRefs = true;
              };
              fetch = {
                prune = true;
              };
              pull.ff = "only";
              push = {
                default = "simple";
                autoSetupRemote = true;
              };
              branch = {
                main.mergeoptions = "--no-ff";
                master.mergeoptions = "--no-ff";
                develop.mergeoptions = "--no-ff";
              };
              tag = {
                sort = "version:refname";
              };
              diff = {
                algorithm = "histogram";
                colorMoved = "default";
                mnemonicPrefix = true;
                renames = true;
              };
              # mergiraf needs diff3 to work properly, and the home-manager module will set that automatically
              merge.conflictstyle = lib.mkIf (!config.programs.mergiraf.enableGitIntegration) "zdiff3";
              rerere = {
                enable = true;
                autoupdate = true;
              };
              trailer = {
                where = "after";
                ifexists = "addIfDifferent";
              };
              credential.helper = lib.mkDefault (
                lib.getExe' config.programs.git.package (
                  if isLinux then "git-credential-libsecret" else "git-credential-osxkeychain"
                )
              );
              gpg = {
                format = "ssh";
                ssh = {
                  allowedSignersFile = "~/.ssh/allowed_signers";
                  program =
                    if isLinux then
                      (lib.getExe' pkgs._1password-gui "op-ssh-sign")
                    else
                      "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
                };
              };
            };
            includes = [
              {
                condition = "gitdir:~/projects/work/ninetech/";
                contents = ninetechConfig;
              }
              {
                condition = "gitdir:~/projects/serveit/";
                contents = ninetechConfig;
              }
              {
                condition = "gitdir:~/projects/toolpal/";
                contents = ninetechConfig;
              }
              {
                condition = "gitdir:~/projects/plendo/";
                contents = ninetechConfig;
              }
              {
                condition = "gitdir:~/repos/ssh.dev.azure.com/v3/ToolPal/";
                contents = ninetechConfig;
              }
            ];
          };
        };
      };
  };
}
