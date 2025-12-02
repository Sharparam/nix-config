{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.zsh;
  starshipConfigPath = "${config.home.homeDirectory}/repos/github.com/Sharparam/nix-config/dotfiles/config/starship.toml";
in {
  options.${namespace}.tools.zsh = with types; {
    enable = mkEnableOption "ZSH";
    enableFastSyntaxHighlighting = mkBoolOpt true "Enable fast syntax highlighting";
  };

  config = mkIf cfg.enable {
    # ${namespace}.tools.atuin.enableZvmWorkaround = true;
    # xdg.configFile."starship.toml".source = mkForce (
    #   config.lib.file.mkOutOfStoreSymlink starshipConfigPath
    # );
    programs = {
      zsh = {
        enable = true;
        dotDir = ".config/zsh";
        enableCompletion = true;
        enableVteIntegration = true;
        syntaxHighlighting.enable = !cfg.enableFastSyntaxHighlighting;
        autocd = true;
        autosuggestion.enable = true;
        defaultKeymap = "viins";
        localVariables = {
          ZVM_INIT_MODE = "sourcing";
          ZVM_LAZY_KEYBINDINGS = false;
          ZVM_LINE_INIT_MODE = "i";
        };
        initContent = lib.mkOrder 550 ''
          path+="$HOME/.local/bin"
        '';
        plugins = [
          {
            name = "zsh-nix-shell";
            src = pkgs.zsh-nix-shell;
            file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
          }

          # zsh-vi-mode overwrites other bindings:
          # https://github.com/jeffreytse/zsh-vi-mode/issues/299
          # See workaround:
          # https://github.com/atuinsh/atuin/issues/1826
          {
            name = "zsh-vi-mode";
            src = pkgs.zsh-vi-mode;
            file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
          }
          {
            name = "zsh-catppuccin-syntax-highlighting";
            src = config.catppuccin.sources.zsh-syntax-highlighting;
            file = "catppuccin_${config.catppuccin.zsh-syntax-highlighting.flavor}-zsh-syntax-highlighting.zsh";
          }
          (mkIf cfg.enableFastSyntaxHighlighting {
            name = "zsh-fast-syntax-highlighting";
            src = pkgs.zsh-fast-syntax-highlighting;
            file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
          })
          {
            name = "zsh-you-should-use";
            src = pkgs.zsh-you-should-use;
            file = "share/zsh/plugins/you-should-use/you-should-use.plugin.zsh";
          }
        ];
        prezto = {
          enable = true;
          pmodules = [
            "helper"
            "spectrum"
            "history"
            "environment"
            "directory"
            "utility"
            "git"
            "ruby"
            "rails"
            "python"
            "node"
            "completion"
          ];
          python = {
            virtualenvAutoSwitch = true;
          };
          utility = {
            safeOps = false;
          };
        };
      };

      starship = {
        enable = true;
        settings = {
          right_format = "$status";
          character = {
            success_symbol = "[❯](purple)";
            error_symbol = "[❯](red)";
            vimcmd_symbol = "[❮](green)";
          };
          directory = {
            style = "blue";
            read_only = " 󰌾";
            # truncation_symbol = "…/"
            substitutions = {
              "E:/Users/adamh" = "(E:) ~";
              "F:/Users/adamh" = "(F:) ~";
              "G:/Users/adamh" = "(G:) ~";
            };
          };
          cmd_duration = {
            format = "[$duration]($style) ";
            # format = "⏱  [$duration](bold yellow)"
            style = "yellow";
          };
          c = {
            symbol = "  ";
          };
          crystal = {
            symbol = "  ";
          };
          direnv = {
            disabled = true;
          };
          docker_context = {
            symbol = "  ";
          };
          elixir = {
            symbol = "  ";
          };
          fennel = {
            symbol = "  ";
          };
          fossil_branch = {
            symbol = " ";
          };
          gcloud = {
            disabled = true;
          };
          git_branch = {
            format = "[$branch(:$remote_branch)]($style) ";
            style = "bright-black";
            symbol = " ";
          };
          git_commit = {
            tag_disabled = false;
            tag_symbol = "  ";
          };
          git_metrics = {
            disabled = true;
          };
          git_status = {
            format = "([$all_status$ahead_behind]($style) )";
            conflicted = "⚠️";
            ahead = "[⇡\${count}](green)";
            behind = "⇣\${count}";
            diverged = "[⇡\${ahead_count}⇣\${behind_count}](bold red)"; # ⇕
            up_to_date = "";
            untracked = "[?\${count}](red)";
            stashed = "≡\${count}";
            modified = "~\${count}";
            staged = "[+\${count}](green)";
            renamed = "»\${count}";
            deleted = "[-\${count}](red)";
            typechanged = "";
            style = "cyan";
            # style = "bold yellow";
            ignore_submodules = false;
          };
          golang = {
            symbol = " ";
          };
          haskell = {
            symbol = " ";
          };
          java = {
            symbol = " ";
          };
          kotlin = {
            symbol = " ";
          };
          lua = {
            symbol = " ";
          };
          meson = {
            symbol = "󰔷 ";
          };
          nix_shell = {
            symbol = " ";
          };
          nodejs = {
            symbol = " ";
          };
          package = {
            symbol = "󰏗 ";
          };
          perl = {
            symbol = " ";
          };
          php = {
            symbol = " ";
          };
          python = {
            symbol = " ";
          };
          ruby = {
            symbol = " ";
          };
          rust = {
            symbol = "󱘗 ";
          };
          status = {
            format = "[$symbol$status( $common_meaning)]($style)";
            symbol = "";
            pipestatus = true;
            disabled = false;
          };
          sudo = {
            disabled = false;
          };
        };
      };
    };
  };
}
