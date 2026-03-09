{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.fzf;
in
{
  options.${namespace}.tools.fzf = {
    enable = mkEnableOption "fzf";
  };

  config = mkIf cfg.enable {
    programs.fzf =
      let
        fd = "fd";
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
