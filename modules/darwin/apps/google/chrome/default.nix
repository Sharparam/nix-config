{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.google.chrome;
in {
  options.${namespace}.apps.google.chrome = with types; {
    enable = mkEnableOption "Enable Google Chrome.";
  };

  config = mkIf cfg.enable {
    homebrew.casks = ["google-chrome"];
  };
}
