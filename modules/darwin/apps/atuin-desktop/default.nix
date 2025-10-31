{
  lib,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.atuin-desktop;
in {
  options.${namespace}.apps.atuin-desktop = with types; {
    enable = mkEnableOption "Enable atuin-desktop.";
  };

  config = mkIf cfg.enable {
    homebrew.casks = ["atuin-desktop"];
  };
}
