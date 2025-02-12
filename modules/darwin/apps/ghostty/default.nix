{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.ghostty;
in {
  options.${namespace}.apps.ghostty = with types; {
    enable = mkEnableOption "Enable ghostty.";
  };

  config = mkIf cfg.enable {
    homebrew.casks = ["ghostty"];
  };
}
