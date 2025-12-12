{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.signal;
in {
  options.${namespace}.apps.signal = {
    enable = mkEnableOption "Enable Signal";
  };

  config = mkIf cfg.enable {
    homebrew.casks = ["signal"];
  };
}
