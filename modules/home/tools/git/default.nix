{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.git;
  is-linux = pkgs.stdenv.isLinux;
  _1PasswordSigningKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAZcQxmr5ZfF/d0YqEZfhr0ZjuHUjxKBf7YgVjYqS+gE";
  sshSigningProgram =
    if is-linux
    then (getExe' pkgs._1password-gui "op-ssh-sign")
    else "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"; # TODO: Fix?
  ninetechConfig = {
    user.email = "adam.hellberg@ninetech.com";
  };
  difftasticPackage = pkgs.difftastic;
in {
  options.${namespace}.tools.git = with types; {
    enable = mkEnableOption "Git";
    use1Password = mkBoolOpt false "Use 1Password integration.";
    userName = mkOpt str "Adam Hellberg" "The name to configure Git with.";
    userEmail = mkOpt str "sharparam@sharparam.com" "The email to configure Git with.";
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
      difftasticPackage
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
              # TODO: Cannot currently combine modifiers with enter key in custom keybinds
              # https://github.com/jesseduffield/lazygit/issues/4258
              # Default <a-enter> conflicts with skhd binding to spawn terminal
              # confirmInEditor = "<c-enter>";
            };
          };
        };
      };
      zsh = {
        sessionVariables = {
          GITHUB_USER = "Sharparam";
        };
      };
      mergiraf.enable = true;
    };

    programs.git = {
      enable = true;
      lfs = enabled;
      signing = {
        key =
          if cfg.use1Password
          then "key::${_1PasswordSigningKey}"
          else cfg.signingKey;
        signByDefault = true;
      };
      settings = {
        user = {
          name = cfg.userName;
          email = cfg.userEmail;
        };
        core = {
          autocrlf = "input";
          askPass = mkIf (cfg.askPass != null) cfg.askPass;
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
          # pruneTags removes *all* local tags, might not be what we want
          # pruneTags = true;
          # all = true;
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
          colorMoved = "plain";
          mnemonicPrefix = true;
          renames = true;
        };
        merge.conflictstyle = "zdiff3";
        rerere = {
          enabled = true;
          autoupdate = true;
        };
        trailer = {
          where = "after";
          ifexists = "addIfDifferent";
        };
        credential.helper =
          if cfg.credentialHelper != null
          then cfg.credentialHelper
          else if is-linux
          then getExe' config.programs.git.package "git-credential-libsecret"
          else getExe' config.programs.git.package "git-credential-osxkeychain";
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
          behavior = "own";
          backend =
            if cfg.use1Password
            then "ssh"
            else "gpg";
          key =
            if cfg.use1Password
            then _1PasswordSigningKey
            else cfg.signingKey;
          backends.ssh = {
            allowed-signers = "~/.ssh/allowed_signers";
            program = sshSigningProgram;
          };
        };
        git = {
          auto-local-bookmark = false;
          colocate = true;
          private-commits = "blacklist()";
          push-bookmark-prefix = "sharparam/push-";
          sign-on-push = true;
          write-change-id-header = true;
        };
        ui = {
          default-command = "log";
          diff.tool = "difft";
          merge-editor = "mergiraf";
          show-cryptographic-signatures = true;
        };
        merge-tools.difft = {
          program = "difft";
          diff-args = ["--color=always" "$left" "$right"];
        };
        aliases = {
          d = ["diff"];
          s = ["show"];
          ll = ["log" "--template" "builtin_log_detailed"];
          tug = ["bookmark" "move" "--from" "heads(::@- & bookmarks())" "--to" "@-"];
        };
        revset-aliases = {
          "gh_pages()" = ''ancestors(remote_bookmarks(exact:"gh-pages"))'';
          "wip()" = ''description(glob:"wip:*")'';
          "private()" = ''description(glob:"private:*")'';
          "blacklist()" = "wip() | private()";
        };
        templates = {
          commit_trailers = ''
            format_signed_off_by_trailer(self)
            ++ if(!trailers.contains_key("Change-Id"), format_gerrit_change_id_trailer(self))
          '';
          draft_commit_description = ''
            concat(
              coalesce(description, default_commit_description, "\n"),
              surround(
                "\nJJ: This commit contains the following changes:\n", "",
                indent("JJ:     ", diff.stat(72)),
              ),
              "\nJJ: ignore-rest\n",
              diff.git(),
            )
          '';
        };
        template-aliases = {
          "format_short_signature(sig)" = ''"<" ++ if(sig.email(), sig.email(), label("text warning", "NO EMAIL")) ++ ">"'';
          "format_short_cryptographic_signature(sig)" = ''
            if(sig, sig.status(), "(no sig)")
          '';
        };
      };
    };

    programs.difftastic = {
      enable = true;
      package = difftasticPackage;
      options = {
        background = "dark";
      };
      git = {
        enable = true;
        diffToolMode = true;
      };
    };

    ${namespace}.cli.aliases = let
      git = "${pkgs.git}/bin/git";
      # gh = "${pkgs.gh}/bin/gh";
      # Don't use the direct package path because 1Password will make an alias
      # for `gh` to automatically inject secrets
      gh = "gh";
    in {
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
