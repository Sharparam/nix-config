{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    optional
    types
    ;
  cfg = config.${namespace}.tools.hyfetch;
in
{
  options.${namespace}.tools.hyfetch = {
    enable = mkEnableOption "hyfetch";
    backend = mkOption {
      type = types.enum [
        "neofetch"
        "fastfetch"
      ];
      default = "neofetch";
      description = "The backend to use for fetching system information.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.hyfetch
    ]
    ++ optional (cfg.backend == "fastfetch") pkgs.fastfetch;

    # Sadly we have to disable the pride month animation since the config file
    # is read-only when managed by home-manager.
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
        "backend": "${cfg.backend}",
        "args": null,
        "distro": null,
        "pride_month_shown": [],
        "pride_month_disable": true
      }
    '';
  };
}
