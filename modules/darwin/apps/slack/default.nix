{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.apps.slack;
in
{
  options.${namespace}.apps.slack = {
    enable = mkEnableOption "Slack";
  };

  config = mkIf cfg.enable {
    homebrew =
      if config.${namespace}.tools.homebrew.enableMas then
        {
          masApps = {
            "Slack" = 803453959;
          };
        }
      else
        {
          casks = [ "slack" ];
        };
  };
}
