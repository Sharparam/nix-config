{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.tools.git;
  is-linux = pkgs.stdenv.isLinux;
  is-darwin = pkgs.stdenv.isDarwin;
  user = config.${namespace}.user;
  _1PasswordSigningKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAZcQxmr5ZfF/d0YqEZfhr0ZjuHUjxKBf7YgVjYqS+gE";
  sshSigningProgram =
    if is-linux then
      (getExe' pkgs._1password-gui "op-ssh-sign")
    else
      "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"; # TODO: Fix?
  ninetechConfig = {
    user.email = "adam.hellberg@ninetech.com";
  };
in
{
  options.${namespace}.tools.git = with types; {
    enable = mkEnableOption "Git";
    use1Password = mkBoolOpt false "Use 1Password integration.";
    userName = mkOpt str user.fullName "The name to configure Git with.";
    userEmail = mkOpt str user.email "The email to configure Git with.";
    signingKey =
      mkOpt str "C58C41E27B00AD04"
        "The GPG key to use for signing commits and tags (ignored if using 1Password).";
    credentialHelper = mkOpt (nullOr str) null "The credential helper to use with Git.";
    askPass = mkOpt (nullOr str) null "The askpass program to use with Git.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ghq
      gh
      lazyjj
    ];

    programs = {
      lazygit = {
        enable = true;
        settings = {
          gui = {
            timeFormat = "02 Jan 2006";
            shortTimeFormat = "15:04";
          };
          keybinding = {
            universal = {
              # Default <a-enter> conflicts with skhd binding to spawn terminal
              confirmInEditor = "<c-enter>";
            };
          };
        };
      };
      zsh = {
        sessionVariables = {
          GITHUB_USER = "Sharparam";
        };
      };
    };

    programs.git = {
      inherit (cfg) userName userEmail;
      enable = true;
      lfs = enabled;
      signing = {
        key = if cfg.use1Password then "key::${_1PasswordSigningKey}" else cfg.signingKey;
        signByDefault = true;
      };
      extraConfig = {
        core = {
          autocrlf = "input";
          askPass = mkIf (cfg.askPass != null) cfg.askPass;
        };
        init.defaultBranch = "main";
        fetch.prune = true;
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
        merge.conflictstyle = "zdiff3";
        rerere.enabled = true;
        trailer = {
          where = "after";
          ifexists = "addIfDifferent";
        };
        credential.helper =
          if cfg.credentialHelper != null then
            cfg.credentialHelper
          else if is-linux then
            getExe' config.programs.git.package "git-credential-libsecret"
          else
            getExe' config.programs.git.package "git-credential-osxkeychain";
        gpg = mkIf cfg.use1Password {
          format = "ssh";
          ssh = {
            allowedSignersFile = "~/.ssh/allowed_signers";
            program = sshSigningProgram;
          };
        };
        github = {
          user = "Sharparam";
          username = "Sharparam";
        };
        ghq.root = "~/repos";
        # Not really using the hub tool anymore since it's deprecated
        hub.protocol = "ssh";
        url = {
          "git@github.com:Sharparam".insteadOf = "https://github.com/Sharparam";
          "git@github.com:SharpWoW".insteadOf = "https://github.com/SharpWoW";
          "git@github.com:chroma-sdk".insteadOf = "https://github.com/chroma-sdk";
          "ssh://git@github.com".pushInsteadOf = "https://github.com";
        };
      };
      includes = [
        {
          condition = "gitdir:~/projects/work/ninetech";
          contents = ninetechConfig;
        }
        {
          condition = "gitdir:~/repos/ssh.dev.azure.com/v3/ToolPal/";
          contents = ninetechConfig;
        }
      ];
      ignores = import ./ignores.nix;
    };

    programs.jujutsu = {
      enable = true;
      settings = {
        user = {
          name = cfg.userName;
          email = cfg.userEmail;
        };
        signing = {
          sign-all = true;
          backend = if cfg.use1Password then "ssh" else "gpg";
          key = if cfg.use1Password then _1PasswordSigningKey else cfg.signingKey;
          backends.ssh = {
            allowed-signers = "~/.ssh/allowed_signers";
            program = sshSigningProgram;
          };
        };
        git = {
          sign-on-push = true;
          subprocess = true;
        };
        ui = {
          show-cryptographic-signatures = true;
        };
        template-aliases = {
          "format_short_cryptographic_signature(sig)" = ''
            if (sig, sig.status(), "(no sig)")
          '';
        };
      };
    };

    ${namespace}.cli.aliases =
      let
        git = "${pkgs.git}/bin/git";
        # gh = "${pkgs.gh}/bin/gh";
        # Don't use the direct package path because 1Password will make an alias
        # for `gh` to automatically inject secrets
        gh = "gh";
      in
      {
        # Commented git aliases are provided by Prezto already
        ga = "${git} add";
        # gb = "${git} branch";
        # gca = "${git} commit --verbose --all";
        # gcaS = "${git} commit --verbose --all --gpg-sign";
        # gcam = "${git} commit --all --message";
        # gcamS = "${git} commit --all --message --gpg-sign";
        # gcm = "${git} commit --message";
        # gcmS = "${git} commit --message --gpg-sign";
        gdt = "${git} difftool";
        # gfr = "${git} pull --rebase";
        # gp = "${git} push";
        # gpf = "${git} push --force-with-lease";
        # gpF = "${git} push --force";
        gst = "${git} status";

        "?" = "${gh} copilot suggeste -t shell";
        "??" = "${gh} copilot explain";
        "?e" = "${gh} copoilot explain";
        "?g" = "${gh} copilot suggest -t git";
        "?gh" = "${gh} copilot suggest -t gh";
      };
  };
}
