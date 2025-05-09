{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.obs;
in {
  options.${namespace}.apps.obs = with types; {
    enable = mkEnableOption "Enable OBS";
  };

  config = mkIf cfg.enable {
    homebrew.casks = ["obs"];
  };
}
