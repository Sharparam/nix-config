{
  lib,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.tools.htop;
in
{
  options.${namespace}.tools.htop = {
    enable = mkEnableOption "Enable htop.";
  };

  config = mkIf cfg.enable {
    programs.htop = enabled;
  };
}
