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
      <apps/ente>
    ];

    homeManager = {
      home.sessionVariables = sessionVariables;
      systemd.user.sessionVariables = sessionVariables;

      home.shellAliases = {
        fsi = "dotnet fsi";
        fsharpi = "dotnet fsi";
        hx = "helix";
        zed = "zeditor";
      };

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
        "zsh/zshrc.d/10-restic.sh".source = ./zshrc.d/10-restic.sh;
        "zsh/zshrc.d/80-gpg.zsh".source = ./zshrc.d/80-gpg.zsh;
        "zsh/zshrc.d/90-raku.zsh".source = ./zshrc.d/90-raku.zsh;
      };

      home.stateVersion = "25.11";
    };
  };
}
