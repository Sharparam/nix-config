{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.tmux;
in
{
  options.${namespace}.tools.tmux = {
    enable = mkEnableOption "tmux";
  };

  config = mkIf cfg.enable {
    programs = {
      tmux = {
        enable = true;
        clock24 = true;
      };

      bash.initExtra = ''
        ts() {
          if (( $# == 0 )); then
            tmux new-session
          else
            tmux new-session -s "$1"
          fi
        }

        ta() {
          if (( $# == 0 )); then
            tmux attach-session
          else
            tmux attach-session -t "$1"
          fi
        }
      '';

      zsh.siteFunctions = {
        ts = ''
          if (( $# == 0 )); then
            tmux new-session
          else
            tmux new-session -s "$1"
          fi
        '';

        ta = ''
          if (( $# == 0 )); then
            tmux attach-session
          else
            tmux attach-session -t "$1"
          fi
        '';
      };
    };
  };
}
