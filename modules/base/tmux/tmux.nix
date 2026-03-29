{ lib, ... }:
{
  den.aspects.base = {
    homeManager =
      { config, pkgs, ... }:
      {
        programs = {
          tmux =
            let
              cfg = config.programs.tmux;
            in
            {
              enable = lib.mkDefault true;
              clock24 = lib.mkDefault true;
              keyMode = "vi";
              mouse = true;
              newSession = true;
              # prefix = "C-a";
              sensibleOnTop = false;
              shortcut = "a";
              plugins =
                let
                  inherit (pkgs) tmuxPlugins;
                in
                lib.optionals (!cfg.sensibleOnTop) [ tmuxPlugins.sensible ]
                ++ builtins.attrValues {
                  inherit (tmuxPlugins)
                    # continuum
                    copycat
                    # fpp
                    open
                    # resurrect
                    urlview
                    yank
                    ;
                };
              extraConfig = builtins.readFile ./tmux.conf;
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
