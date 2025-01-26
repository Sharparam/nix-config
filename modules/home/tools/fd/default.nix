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
  cfg = config.${namespace}.tools.fd;
in
{
  options.${namespace}.tools.fd = with types; {
    enable = mkEnableOption "Whether or not to enable the fd tool.";
  };

  config = mkIf cfg.enable {
    programs.fd = enabled;
  };
}
