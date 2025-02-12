{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.system.interface;
in {
  options.${namespace}.system.interface = with types; {
    enable = mkEnableOption "macOS interface";
  };

  config = mkIf cfg.enable {
    ${namespace}.home.file = {
      "Pictures/screenshots/.keep".text = "";
    };

    system = {
      defaults = {
        CustomSystemPreferences = {
        };

        CustomUserPreferences = {
        };

        NSGlobalDomain = {
          _HIHideMenuBar = config.${namespace}.desktop.sketchybar.enable;
          AppleShowAllExtensions = true;
          AppleShowAllFiles = true;
          AppleShowScrollBars = "Automatic";
        };

        controlcenter = {
          BatteryShowPercentage = true;
        };

        finder = {
          AppleShowAllExtensions = true;
          AppleShowAllFiles = true;
          CreateDesktop = true;
          FXDefaultSearchScope = "SCcf";
          FXEnableExtensionChangeWarning = false;
          QuitMenuItem = true;
          ShowExternalHardDrivesOnDesktop = false;
          ShowHardDrivesOnDesktop = false;
          ShowMountedServersOnDesktop = false;
          ShowPathbar = true;
          ShowRemovableMediaOnDesktop = false;
          ShowStatusBar = true;
          _FXSortFoldersFirst = true;
        };

        loginwindow = {
          DisableConsoleAccess = false;
          GuestEnabled = false;
          # LoginwindowText = "λ";
          # SHOWFULLNAME = true;
        };

        screencapture = {
          disable-shadow = true;
          location = "/Users/${config.${namespace}.user.name}/Pictures/screenshots/";
          type = "png";
        };
      };

      startup = {
        chime = false;
      };
    };
  };
}
