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
  cfg = config.${namespace}.system.locale;
in
{
  options.${namespace}.system.locale = {
    enable = mkEnableOption "Enable locale configuration";
  };

  config = mkIf cfg.enable {
    i18n = {
      defaultLocale = "en_GB.UTF-8";
      extraLocaleSettings = {
        LC_ADDRESS = "en_SE.UTF-8";
        LC_IDENTIFICATION = "sv_SE.UTF-8";
        LC_MEASUREMENT = "en_SE.UTF-8";
        LC_MONETARY = "en_SE.UTF-8";
        LC_NAME = "en_SE.UTF-8";
        LC_NUMERIC = "en_SE.UTF-8";
        LC_PAPER = "sv_SE.UTF-8";
        LC_TELEPHONE = "en_SE.UTF-8";
        LC_TIME = "en_SE.UTF-8";
      };
    };
  };
}
