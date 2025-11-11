{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.etcher;
in {
  options.${namespace}.apps.etcher = with types; {
    enable = mkEnableOption "Enable etcher";
  };

  config = mkIf cfg.enable {
    homebrew.casks = ["balenaetcher"];
  };
}
