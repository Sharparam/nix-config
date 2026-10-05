{ ... }:
{
  den.default = {
    includes = [
      (
        { home }:
        {
          homeManager =
            { pkgs, ... }:
            {
              i18n.glibcLocales = pkgs.glibcLocales.override {
                allLocales = false;
                locales = [
                  "C.UTF-8/UTF-8"
                  "en_DK.UTF-8/UTF-8"
                  "en_GB.UTF-8/UTF-8"
                  "en_SE.UTF-8/UTF-8"
                  "en_US.UTF-8/UTF-8"
                  "sv_SE.UTF-8/UTF-8"
                ];
              };
            };
        }
      )
    ];

    nixos = {
      # Select internationalisation properties.
      i18n.defaultLocale = "en_GB.UTF-8";

      i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_SE.UTF-8";
        LC_IDENTIFICATION = "en_SE.UTF-8";
        LC_MEASUREMENT = "en_SE.UTF-8";
        LC_MONETARY = "en_SE.UTF-8";
        LC_NAME = "en_SE.UTF-8";
        LC_NUMERIC = "en_SE.UTF-8";
        LC_PAPER = "en_SE.UTF-8";
        LC_TELEPHONE = "en_SE.UTF-8";
        LC_TIME = "en_SE.UTF-8";
      };
    };
  };
}
