{
  lib,
  pkgs,
  inputs,
  namespace,
  system,
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
    environment.systemPackages = [
      inputs.locale-en_se.packages.${system}.locale-en_se
    ];

    i18n = {
      glibcLocales =
        let
          en_se = inputs.locale-en_se.packages.${system}.locale-en_se;
        in
        (pkgs.glibcLocales.overrideAttrs (
          final: prev: {
            nativeBuildInputs = prev.nativeBuildInputs ++ [ en_se ];
            preBuild =
              ''
                echo 'HACK: Adding en_SE as a supported locale to glibc'
                cp -v "${en_se}/share/i18n/locales/en_SE" ../glibc-2*/localedata/locales
                echo 'en_SE.UTF-8/UTF-8 \' >> ../glibc-2*/localedata/SUPPORTED
              ''
              + prev.preBuild;
          }
        )).override
          {
            allLocales = any (x: x == "all") config.i18n.supportedLocales;
            locales = config.i18n.supportedLocales;
          };

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
