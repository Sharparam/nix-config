{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.system.time;
in
{
  options.${namespace}.system.time = {
    enable = mkEnableOption "Whether or not to configure timezone information.";
  };

  config = mkIf cfg.enable { time.timeZone = "Europe/Stockholm"; };
}
