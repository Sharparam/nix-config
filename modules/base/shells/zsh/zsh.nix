{
  den.aspects.base = {
    nixos = {
      programs.zsh = {
        enable = true;
        autosuggestions.enable = true;
        histFile = "$XDG_CACHE_HOME/zsh.history";
      };
    };

    darwin = {
      programs.zsh.enable = true;
    };

    homeManager =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      let
        inherit (lib) mkMerge mkOrder;
      in
      {
        programs.zsh =
          let
            catppuccinFlavor = config.catppuccin.flavor;
            catppuccinZshFsh = pkgs.local.catppuccin-zsh-fsh;
            fshThemeName = "catppuccin-${catppuccinFlavor}";
            fshThemeFile = "${catppuccinZshFsh}/share/zsh-fsh/themes/${fshThemeName}.ini";
          in
          {
            enable = true;
            dotDir = "${config.xdg.configHome}/zsh";
            enableCompletion = true;
            enableVteIntegration = true;
            syntaxHighlighting.enable = false;
            autocd = true;
            autosuggestion.enable = true;
            defaultKeymap = "viins";
            localVariables = {
              ZVM_INIT_MODE = "sourcing";
              ZVM_LAZY_KEYBINDINGS = false;
              ZVM_LINE_INIT_MODE = "i";
            };
            initContent =
              let
                zshConfigFirst = mkOrder 500 "";
                zshConfigBeforeCompInit = mkOrder 550 ''
                  # path+="$HOME/.local/bin"
                '';
                zshConfig = mkOrder 1000 "";
                zshConfigLast = mkOrder 1500 ''
                  if [[ "$\{FAST_THEME_NAME:-}" != "${fshThemeName}" ]]; then
                    fast-theme --quiet "${fshThemeFile}"
                  fi
                '';
                zshrcd = mkOrder 2000 (builtins.readFile ./zshrcd.zsh);
              in
              mkMerge [
                zshConfigFirst
                zshConfigBeforeCompInit
                zshConfig
                zshConfigLast
                zshrcd
              ];
            plugins = [
              # zsh-vi-mode overwrites other bindings:
              # https://github.com/jeffreytse/zsh-vi-mode/issues/299
              # See workaround:
              # https://github.com/atuinsh/atuin/issues/1826
              {
                name = "zsh-vi-mode";
                src = pkgs.zsh-vi-mode;
                file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
              }
              # Only works for normal syntax highlight, not fast
              # {
              #   name = "zsh-catppuccin-syntax-highlighting";
              #   src = config.catppuccin.sources.zsh-syntax-highlighting;
              #   file = "catppuccin_${config.catppuccin.zsh-syntax-highlighting.flavor}-zsh-syntax-highlighting.zsh";
              # }
              {
                name = "zsh-fast-syntax-highlighting";
                src = pkgs.zsh-fast-syntax-highlighting;
                file = "share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh";
              }
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
                "python"
                "completion"
              ];
              editor.keymap = "vi";
              prompt.theme = null;
              python = {
                virtualenvAutoSwitch = true;
              };
              utility = {
                safeOps = false;
              };
            };
          };
      };
  };
}
