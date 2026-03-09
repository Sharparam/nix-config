{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.htop;
in
{
  options.${namespace}.tools.htop = {
    enable = mkEnableOption "htop";
  };

  config = mkIf cfg.enable {
    programs.htop.enable = true;
  };
}
