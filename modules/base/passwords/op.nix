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
      {
        config,
        lib,
        ...
      }:
      let
        sshAuthSock = "$HOME/.1password/agent.sock";
        opPlugins = "$HOME/.config/op/plugins.sh";
        sessionVariables = {
          SSH_AUTH_SOCK = sshAuthSock;
        };
        sops = config.sops;
      in
      {
        home.sessionVariables = sessionVariables;
        systemd.user.sessionVariables = sessionVariables;

        sops = {
          secrets = {
            op-a-family-id = { };
            op-a-family-v-private-id = { };
            op-a-work-id = { };
            op-a-work-v-employee-id = { };
          };

          templates."op-ssh-agent.toml" = {
            path = "${config.xdg.configHome}/1Password/ssh/agent.toml";
            content = ''
              [[ssh-keys]]
              account = "${sops.placeholder.op-a-family-id}"
              vault = "${sops.placeholder.op-a-family-v-private-id}"

              [[ssh-keys]]
              account = "${sops.placeholder.op-a-work-id}"
              vault = "${sops.placeholder.op-a-work-v-employee-id}"
            '';
          };
        };

        # xdg.configFile."1Password/ssh/agent.toml".source = sops.templates."op-ssh-agent.toml".path;

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
