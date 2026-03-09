{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.apps.telegram;
in
{
  options.${namespace}.apps.telegram = {
    enable = mkEnableOption "Telegram";
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
