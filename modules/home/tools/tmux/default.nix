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
  cfg = config.${namespace}.tools.tmux;
in
{
  options.${namespace}.tools.tmux = {
    enable = mkEnableOption "tmux";
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      clock24 = true;
    };

    ${namespace}.cli.aliases = {
      ts = ''
        if (($# == 0)); then
          tmux new-session
        else
          tmux new-session -s "$1"
        fi
      '';

      ta = ''
        if (($# == 0)); then
          tmux attach-session
        else
          tmux attach-session -t "$1"
        fi
      '';
    };
  };
}
