{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.apps.signal;
in
{
  options.${namespace}.apps.signal = {
    enable = mkEnableOption "Signal";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "signal" ];
  };
}
