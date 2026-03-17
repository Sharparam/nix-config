{
  den.aspects.base = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.hyfetch ];

        xdg.configFile."hyfetch.json".text = ''
          {
            "preset": "pansexual",
            "mode": "rgb",
            "light_dark": "dark",
            "lightness": 0.65,
            "color_align": {
              "mode": "horizontal",
              "custom_colors": [],
              "fore_back": null
            },
            "backend": "neofetch",
            "args": null,
            "distro": null,
            "pride_month_shown": [],
            "pride_month_disable": true
          }
        '';
      };
  };
}
