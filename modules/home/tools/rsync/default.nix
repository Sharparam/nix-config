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

    home.shellAliases =
      let
        rsync = "${pkgs.rsync}/bin/rsync";
      in
      {
        rsync = "${rsync} --info=progress2 --partial -h";
      };
  };
}
