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
  cfg = config.${namespace}.tools.rsync;
in
{
  options.${namespace}.tools.rsync = {
    enable = mkEnableOption "rsync";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      rsync
    ];
  };
}
