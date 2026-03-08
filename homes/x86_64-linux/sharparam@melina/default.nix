{
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
{
  snix = {
    tools = {
      atuin = enabled;
      bat = enabled;
      devenv = enabled;
      direnv = enabled;
      fd = enabled;
      fzf = enabled;
      git = {
        enable = true;
        use1Password = true;
        credentialHelper = "libsecret";
        askPass = "/usr/bin/ksshaskpass";
      };
      home-manager = enabled;
      lsd = enabled;
      mise = enabled;
      zoxide = enabled;
      zsh = enabled;
    };
    cli.aliases = {
      fsi = "dotnet fsi";
      fsharpi = "dotnet fsi";
      hx = "helix";
      rbbi = "bundle install";
      rsync = "rsync --info=progress2 --partial -h";
      zed = "zeditor";
    };
  };

  home.packages = with pkgs; [
    alejandra
    cachix
    deadnix
    nixd
    nixfmt
    statix
  ];

  programs = {
    bun.enable = true;
    zsh = {
      # package = null; # Use Arch Linux package
      sessionVariables = {
        ANSIBLE_NOCOWS = 1;
        CMAKE_GENERATOR = "Ninja";
        DOOMDIR = "$HOME/.config/doom"; # Since we don't manage Emacs through HM
        DOTNET_CLI_TELEMETRY_OPTOUT = 1;
        FLAKE_CONFIG_URI = ''$HOME/repos/github.com/Sharparam/nix-config#homeConfigurations.\"$USER@$HOST\"'';
        GOPATH = "$HOME/.go";
        MAKEFLAGS = "-j$(nproc)";
        MANPAGER = "nvim -M +Man!";
        PERL5LIB = "$HOME/.perl5/lib/perl5$\{PERL5LIB:+:$\{PERL5LIB}}";
        PERL_LOCAL_LIB_ROOT = "$HOME/.perl5$\{PERL_LOCAL_LIB_ROOT:+:$\{PERL_LOCAL_LIB_ROOT}}";
        PERL_MB_OPT = ''--install_base \"$HOME/.perl5\"'';
        PERL_MM_OPT = "INSTALL_BASE=$HOME/.perl5";
      };
    };
  };

  services.lorri.enable = true;

  xdg.configFile = {
    "zsh/zshrc.d/10-cargo.sh".source = ./zshrc.d/10-cargo.sh;
    "zsh/zshrc.d/10-go.zsh".source = ./zshrc.d/10-go.zsh;
    "zsh/zshrc.d/10-perl5.zsh".source = ./zshrc.d/10-perl5.zsh;
    "zsh/zshrc.d/10-restic.sh".source = ./zshrc.d/10-restic.sh;
    "zsh/zshrc.d/80-gpg.zsh".source = ./zshrc.d/80-gpg.zsh;
    "zsh/zshrc.d/90-raku.zsh".source = ./zshrc.d/90-raku.zsh;
  };

  home.stateVersion = "25.11";
}
