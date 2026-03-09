{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.fd;
in
{
  options.${namespace}.tools.fd = {
    enable = mkEnableOption "Whether or not to enable the fd tool.";
  };

  config = mkIf cfg.enable {
    programs.fd.enable = true;
  };
}
