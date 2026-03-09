{
  pkgs,
  ...
}:
{
  snix = {
    tools = {
      atuin.enable = true;
      bash = {
        enable = true;
        package = null;
      };
      bat.enable = true;
      devenv.enable = true;
      direnv.enable = true;
      fd.enable = true;
      fzf.enable = true;
      git = {
        enable = true;
        use1Password = true;
        credentialHelper = "libsecret";
        askPass = "/usr/bin/ksshaskpass";
      };
      home-manager.enable = true;
      lsd.enable = true;
      mise.enable = true;
      nh.enable = true;
      nushell = {
        enable = true;
        package = null;
      };
      starship.enable = true;
      zoxide.enable = true;
      zsh.enable = true;
    };
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

  home.sessionPath = [
    "$HOME/.config/emacs/bin"
  ];

  home.sessionVariables = {
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

  home.shellAliases = {
    emacs = "emacsclient --no-wait --create-frame";
    fsi = "dotnet fsi";
    fsharpi = "dotnet fsi";
    hx = "helix";
    rbbi = "bundle install";
    rsync = "rsync --info=progress2 --partial -h";
    zed = "zeditor";
  };

  programs = {
    bun.enable = true;
    zsh = {
      # package = null; # Use Arch Linux package
    };
  };

  services.lorri.enable = true;

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
}
