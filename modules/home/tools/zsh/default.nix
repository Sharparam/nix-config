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
  cfg = config.${namespace}.tools.zsh;
  starshipConfigPath = "${config.home.homeDirectory}/repos/github.com/Sharparam/nix-config/dotfiles/config/starship.toml";
in
{
  options.${namespace}.tools.zsh = with types; {
    enable = mkEnableOption "ZSH";
    enableFastSyntaxHighlighting = mkBoolOpt true "Enable fast syntax highlighting";
  };

  config = mkIf cfg.enable {
    # ${namespace}.tools.atuin.enableZvmWorkaround = true;
    xdg.configFile."starship.toml".source = mkForce (
      config.lib.file.mkOutOfStoreSymlink starshipConfigPath
    );
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
      };
    };
  };
}
