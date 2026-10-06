{lib, ...}: {
  den.aspects.desktops.provides.noctalia-niri = let
    inherit (lib) mkDefault;
  in {
    nixos = {pkgs, ...}: {
      programs.noctalia = {
        enable = mkDefault true;
        recommendedServices.enable = mkDefault true;
        systemd.enable = mkDefault true;
      };
      services.displayManager.noctalia-greeter = {
        enable = mkDefault true;
        passwordlessSyncUsers = ["sharparam"];
        settings = {
          appearance = {
            hide_logo = true;
            scheme = "Synced";
            scheme_selector_position = "hidden";
            theme_mode = "dark";
          };
          auth = {
            allow_empty_password = true;
          };
        };
      };
    };

    homeManager = {pkgs, ...}: {
      programs.noctalia = {
        enable = mkDefault true;
        systemd.enable = mkDefault true;
        checkConfig = mkDefault true;
        settings = {
          lockscreen = {
            allow_empty_password = true;
          };
          shell = {
            avatar_path = "~/pictures/profile.png";
            launch_apps_as_systemd_services = true;
            niri_overview_type_to_launch_enabled = false;
            polkit_agent = true;
            settings_show_advanced = true;
            greeter_sync = {
              auto_sync = true;
            };
          };
          theme = {
            mode = "dark";
            shell_mode = "follow";
            source = "builtin";
            builtin = "Catppuccin";
          };
        };
      };
      wayland.windowManager.niri.settings = {
        binds = {
          "Mod+Space" = {
            _props.hotkey-overlay-title = "Toggle launcher";
            spawn = ["noctalia" "msg" "panel-toggle" "launcher"];
          };
          "Super+Alt+L" = {
            _props.hotkey-overlay-title = "Lock screen";
            spawn = ["noctalia" "msg" "session" "lock"];
          };
          "Super+Alt+Q".spawn = ["noctalia" "msg" "session" "lock"];
          "Ctrl+Alt+Delete" = {
            _props.hotkey-overlay-title = "Open power panel";
            spawn = ["noctalia" "msg" "panel-toggle" "session"];
          };
          "Mod+Shift+E".spawn = ["noctalia" "msg" "panel-toggle" "session"];
          "Alt+Tab".spawn = ["noctalia" "msg" "window-switcher" "hold"];
          "Mod+S".spawn = ["noctalia" "msg" "panel-toggle" "control-center"];
          "Mod+Ctrl+S".spawn = ["noctalia" "msg" "settings-toggle"];
          "XF86AudioRaiseVolume" = {
            _props.allow-when-locked = true;
            spawn = ["noctalia" "msg" "volume-up"];
          };
          "XF86AudioLowerVolume" = {
            _props.allow-when-locked = true;
            spawn = ["noctalia" "msg" "volume-down"];
          };
          "XF86AudioMute" = {
            _props.allow-when-locked = true;
            spawn = ["noctalia" "msg" "volume-mute"];
          };
          "XF86MonBrightnessUp" = {
            _props.allow-when-locked = true;
            spawn = ["noctalia" "msg" "brightness-up"];
          };
          "XF86MonBrightnessDown" = {
            _props.allow-when-locked = true;
            spawn = ["noctalia" "msg" "brightness-down"];
          };
          "XF86AudioPlay" = {
            _props.allow-when-locked = true;
            spawn = ["noctalia" "msg" "media" "toggle"];
          };
          "XF86AudioStop" = {
            _props.allow-when-locked = true;
            spawn = ["noctalia" "msg" "media" "stop"];
          };
          "XF86AudioPrev" = {
            _props.allow-when-locked = true;
            spawn = ["noctalia" "msg" "media" "previous"];
          };
          "XF86AudioNext" = {
            _props.allow-when-locked = true;
            spawn = ["noctalia" "msg" "media" "next"];
          };
        };
        debug.honor-xdg-activation-with-invalid-serial = {};
        _children = [
          {
            window-rule._children = [
              {geometry-corner-radius = 12;}
              {clip-to-geometry = true;}
            ];
          }
          {
            window-rule._children = [
              {match._props.app-id = "dev.noctalia.Noctalia";}
              {open-floating = true;}
              {default-column-width.fixed = 1080;}
              {default-window-height.fixed = 920;}
            ];
          }
        ];
      };
    };
  };
}
