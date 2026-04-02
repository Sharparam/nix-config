{
  den.aspects.base.darwin = {
    system = {
      defaults = {
        CustomSystemPreferences = {
        };

        CustomUserPreferences = {
        };

        NSGlobalDomain = {
          AppleShowAllExtensions = true;
          AppleShowAllFiles = true;
          AppleShowScrollBars = "Automatic";
          NSStatusItemSelectionPadding = 2;
          NSStatusItemSpacing = 2;
          NSWindowShouldDragOnGesture = true;
        };

        WindowManager = {
          EnableStandardClickToShowDesktop = false;
          StandardHideDesktopIcons = true;
        };

        controlcenter = {
          BatteryShowPercentage = true;
        };

        dock = {
          autohide = true;
          mru-spaces = false;
          orientation = "left";
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
          type = "png";
        };
      };

      startup = {
        chime = false;
      };
    };
  };
}
