{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.apps.kde-connect;
in
{
  options.${namespace}.apps.kde-connect = {
    enable = mkEnableOption "Enable KDE Connect.";
  };

  config = mkIf cfg.enable {
    homebrew.masApps = {
      "KDE Connect" = 1580245991;
    };
  };
}
