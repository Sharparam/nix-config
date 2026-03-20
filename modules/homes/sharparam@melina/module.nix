{ __findFile, ... }:
let
  username = "sharparam";
  hostname = "melina";
  identifier = "${username}@${hostname}";

  sessionVariables = {
    ANSIBLE_NOCOWS = 1;
    BROWSER = "firefox";
    CMAKE_GENERATOR = "Ninja";
    DOOMDIR = "$HOME/.config/doom"; # Since we don't manage Emacs through HM
    DOTNET_CLI_TELEMETRY_OPTOUT = 1;
    EDITOR = "nvim";
    FLAKE_CONFIG_URI = ''$HOME/repos/github.com/Sharparam/nix-config#homeConfigurations.\"$USER@$HOST\"'';
    GOPATH = "$HOME/.go";
    MAKEFLAGS = "-j$(nproc)";
    MANPAGER = "nvim -M +Man!";
    PERL5LIB = "$HOME/.perl5/lib/perl5$\{PERL5LIB:+:$\{PERL5LIB}}";
    PERL_LOCAL_LIB_ROOT = "$HOME/.perl5$\{PERL_LOCAL_LIB_ROOT:+:$\{PERL_LOCAL_LIB_ROOT}}";
    PERL_MB_OPT = ''--install_base \"$HOME/.perl5\"'';
    PERL_MM_OPT = "INSTALL_BASE=$HOME/.perl5";
    SSH_AUTH_SOCK = "$HOME/.1password/agent.sock";
    TERMINAL = "ghostty";
    VISUAL = "nvim";
  };
in
{
  den.homes.x86_64-linux."${identifier}" = {
    userName = username;
    aspect = identifier;
  };

  den.aspects."${identifier}" = {
    includes = [
      <nix-allowed-user>
      <nix-trusted-user>
      <den/define-user>
      (<den/user-shell> "zsh")

      <sharparam/gpg>

      <base>
      <base/home>

      <ssh/home>

      <catppuccin>

      <apps/ast-grep>
      <apps/codespelunker>
      <apps/just>
      <apps/mise>
      <apps/neovim>
      <apps/scc>
      <apps/tokei>
      <apps/uv>
    ];

    homeManager =
      { pkgs, ... }:
      {
        home.sessionPath = [
          "$HOME/.config/emacs/bin"
        ];

        home.sessionVariables = sessionVariables;
        systemd.user.sessionVariables = sessionVariables;

        home.shellAliases = {
          emacs = "emacsclient --no-wait --create-frame";
          fsi = "dotnet fsi";
          fsharpi = "dotnet fsi";
          hx = "helix";
          rbbi = "bundle install";
          rsync = "rsync --info=progress2 --partial -h";
          vi = "nvim";
          vim = "nvim";
          zed = "zeditor";
        };

        home.packages = builtins.attrValues {
          inherit (pkgs)
            alejandra
            cachix
            deadnix
            nixd
            nixfmt
            nix-output-monitor
            statix
            ;
        };

        catppuccin = {
          flavor = "macchiato";
        };

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
          "zsh/zshrc.d/90-1password.sh".source = ./zshrc.d/90-1password.sh;
          "zsh/zshrc.d/90-raku.zsh".source = ./zshrc.d/90-raku.zsh;
        };

        home.stateVersion = "25.11";
      };
  };
}
