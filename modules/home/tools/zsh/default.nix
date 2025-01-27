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
in
{
  options.${namespace}.tools.zsh = {
    enable = mkEnableOption "ZSH";
  };

  config = mkIf cfg.enable {
    ${namespace}.tools.atuin.enableZvmWorkaround = true;
    programs = {
      zsh = {
        enable = true;
        dotDir = ".config/zsh";
        enableCompletion = true;
        syntaxHighlighting.enable = true;
        autocd = true;
        autosuggestion.enable = true;
        defaultKeymap = "viins";
        # initExtra = ''
        #   bindkey -vi
        # '';
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
        ];
      };

      starship = {
        enable = true;
      };
    };
  };
}
