{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.rsync;
in
{
  options.${namespace}.tools.rsync = {
    enable = mkEnableOption "rsync";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.rsync
    ];

    home.shellAliases = {
      rsync = "rsync --info=progress2 --partial -h";
    };
  };
}
