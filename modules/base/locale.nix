{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  den.aspects.base = {
    nixos = {
      i18n = {
        defaultLocale = mkDefault "en_GB.UTF-8";
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
  };
}
