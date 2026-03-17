{ lib, ... }:
{
  den.aspects.base = {
    homeManager = {
      programs = {
        tmux = {
          enable = lib.mkDefault true;
          clock24 = lib.mkDefault true;
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
  };
}
