{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.slack;
in {
  options.${namespace}.apps.slack = with types; {
    enable = mkEnableOption "Enable Slack";
  };

  config = mkIf cfg.enable {
    homebrew =
      if config.${namespace}.tools.homebrew.enableMas
      then {
        masApps = {
          "Slack" = 803453959;
        };
      }
      else {
        casks = ["slack"];
      };
  };
}
