{ __findFile, ... }:
let
  username = "sharparam";
  hostname = "melina";
  identifier = "${username}@${hostname}";

  sessionVariables = {
    FLAKE_CONFIG_URI = ''$HOME/repos/github.com/Sharparam/nix-config#homeConfigurations.\"$USER@$HOST\"'';
    GOPATH = "$HOME/.go";
    PERL5LIB = "$HOME/.perl5/lib/perl5$\{PERL5LIB:+:$\{PERL5LIB}}";
    PERL_LOCAL_LIB_ROOT = "$HOME/.perl5$\{PERL_LOCAL_LIB_ROOT:+:$\{PERL_LOCAL_LIB_ROOT}}";
    PERL_MB_OPT = ''--install_base \"$HOME/.perl5\"'';
    PERL_MM_OPT = "INSTALL_BASE=$HOME/.perl5";
  };
in
{
  den.homes.x86_64-linux."${identifier}" = {
    userName = username;
    aspect = identifier;
  };

  den.aspects."${identifier}" = {
    includes = [
      <sharparam>
      <programs/ente>
      <programs/kitty>
      <programs/zathura>
    ];

    homeManager =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        home.sessionVariables = sessionVariables;
        systemd.user.sessionVariables = sessionVariables;

        home.shellAliases = {
          fsi = "dotnet fsi";
          fsharpi = "dotnet fsi";
          zed = "zeditor";
        };

        home.file."${config.programs.gpg.homedir}/gpg-agent.conf".text = ''
          pinentry-program ${lib.getExe pkgs.pinentry-qt}
        '';

        catppuccin.flavor = "macchiato";

        programs = {
          bash.package = null;
          bun.enable = true;
          ghostty = {
            package = null;
            systemd.enable = false;
          };
          git = {
            settings = {
              core.askPass = "/usr/bin/ksshaskpass";
              credential.helper = "libsecret";
            };
          };
          nushell.package = null;
          vesktop.enable = false;
          zsh = {
            # package = null; # Use Arch Linux package
          };
        };

        xdg.configFile = {
          "zsh/zshrc.d/10-cargo.sh".source = ./zshrc.d/10-cargo.sh;
          "zsh/zshrc.d/10-go.zsh".source = ./zshrc.d/10-go.zsh;
          "zsh/zshrc.d/10-perl5.zsh".source = ./zshrc.d/10-perl5.zsh;
        };

        # Managed by Arch
        xdg.userDirs.enable = false;

        home.stateVersion = "25.11";
      };
  };
}
