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
  cfg = config.${namespace}.system.interface;
in
{
  options.${namespace}.system.interface = with types; {
    enable = mkEnableOption "macOS interface";
  };

  config = mkIf cfg.enable {
    ${namespace}.home.file = {
      "Pictures/screenshots/.keep".text = "";
    };

    system.defaults = {
      CustomSystemPreferences = {
        finder = {
          FXEnableExtensionChangeWarning = false;
          ShowPathbar = true;
        };
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        FXEnableExtensionChangeWarning = false;
      };

      loginWindow = {
        GuestEnabled = false;
        # SHOWFULLNAME = true;
      };

      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        AppleShowScrollBars = "Automatic";
      };

      screencapture = {
        disable-shadow = true;
        location = "/Users/${config.${namespace}.user.name}/Pictures/screenshots/";
        type = "png";
      };
    };
  };
}
