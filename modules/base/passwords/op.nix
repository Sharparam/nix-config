{ __findFile, ... }:
{
  den.aspects.base = {
    includes = [
      (<den/unfree> [
        "_1password"
        "_1password-gui"
        "1password"
        "1password-gui"
      ])

      (
        { host, user }:
        {
          nixos.programs._1password-gui.polkitPolicyOwners = [ user.name ];
        }
      )
    ];

    os = {

    };

    nixos = {
      programs = {
        _1password.enable = true;
        _1password-gui = {
          enable = true;
        };
      };
    };

    darwin = {
      homebrew = {
        # Shouldn't need the tap since 1Password seems to be in default offerings now?
        # taps = [ "1password/tap" ];
        casks = [
          "1password"
          "1password-cli"
        ];

        masApps = {
          "1Password for Safari" = 1569813296;
        };
      };
    };

    homeManager =
      { lib, ... }:
      let
        sshAuthSock = "$HOME/.1password/agent.sock";
        opPlugins = "$HOME/.config/op/plugins.sh";
        sessionVariables = {
          SSH_AUTH_SOCK = sshAuthSock;
        };
      in
      {
        home.sessionVariables = sessionVariables;
        systemd.user.sessionVariables = sessionVariables;

        programs = {
          ssh = {
            includes = [ "~/.ssh/1Password/config" ];
            extraOptionOverrides = {
              IdentityAgent = "~/.1password/agent.sock";
            };
          };

          zsh = {
            initContent = lib.mkAfter ''
              [ -f "${opPlugins}" ] && source "${opPlugins}"
            '';

            inherit sessionVariables;
          };
        };
      };
  };
}
