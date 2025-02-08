{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.apps.telegram;
in
{
  options.${namespace}.apps.telegram = {
    enable = mkEnableOption "Enable Telegram.";
  };

  config = mkIf cfg.enable {
    homebrew =
      if config.${namespace}.tools.homebrew.enableMas then
        {
          masApps = {
            "Telegram" = 747648890;
          };
        }
      else
        {
          casks = [ "telegram" ];
        };
  };
}
