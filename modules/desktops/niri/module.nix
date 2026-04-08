{lib, ...}: {
  den.aspects.desktops.provides.niri = {
    nixos = {
      config,
      pkgs,
      ...
    }: {
      environment.systemPackages = builtins.attrValues {
        inherit
          (pkgs)
          fuzzel
          mako
          swayidle
          swaylock
          xwayland-satellite
          ;
      };

      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
      };

      programs = {
        niri = {
          enable = true;
        };
      };

      services.greetd = {
        settings = {
          default_session = {
            command = "${config.programs.niri.package}/bin/niri-session";
            user = "sharparam";
          };
        };
      };

      services = {
        gnome.gnome-keyring.enable = lib.mkDefault true;
      };

      security = {
        pam.services.swaylock = {};
        polkit.enable = lib.mkDefault true;
      };

      xdg.portal.config.niri = {
        "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
      };
    };

    homeManager = {pkgs, ...}: {
      xdg.configFile."niri/config.kdl".source = ./config.kdl;

      home.packages = builtins.attrValues {
        inherit
          (pkgs)
          swaybg
          xwayland-satellite
          ;
      };

      programs = {
        fuzzel.enable = lib.mkDefault true;
        swaylock.enable = lib.mkDefault true;
        waybar.enable = lib.mkDefault true;
      };

      services = {
        mako.enable = lib.mkDefault true;
        swayidle.enable = lib.mkDefault true;
        polkit-gnome.enable = lib.mkDefault true;
      };
    };
  };
}
