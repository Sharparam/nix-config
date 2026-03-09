{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.${namespace}.system.fonts;
in
{
  imports = [ (lib.snowfall.fs.get-file "modules/shared/system/fonts/default.nix") ];

  config = mkIf cfg.enable {
    environment.systemPackages = builtins.attrValues {
      inherit (pkgs)
        font-manager
        fontpreview
        smile
        ;
    };
    fonts = {
      enableDefaultPackages = true;

      fontconfig = {
        antialias = true;
        hinting.enable = true;

        defaultFonts =
          let
            nerd = [
              "Symbols Nerd Font"
            ];
            emoji = [
              "Noto Color Emoji"
              "Noto Emoji"
            ];
          in
          {
            serif = [ "Noto Serif" ] ++ emoji ++ nerd;
            sansSerif = [ "Noto Sans" ] ++ emoji ++ nerd;
            monospace = [
              "Iosevka Sharpie"
              "Iosevka Nerd Font"
            ]
            ++ nerd;
            inherit emoji;
          };
      };

      fontDir = {
        enable = true;
      };
    };
  };
}
