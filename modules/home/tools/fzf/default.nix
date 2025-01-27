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
  cfg = config.${namespace}.tools.fzf;
in
{
  options.${namespace}.tools.fzf = {
    enable = mkEnableOption "fzf";
  };

  config = mkIf cfg.enable {
    programs.fzf =
      let
        fd = "${pkgs.fd}/bin/fd";
      in
      {
        enable = true;
        defaultCommand = "${fd} --type f --hidden --exclude \".git\"";
        changeDirWidgetCommand = "${fd} --type d --hidden --exclude \".git\"";
        fileWidgetCommand = "${fd} --type f --hidden --exclude \".git\"";

        tmux.enableShellIntegration = true;
      };
  };
}
