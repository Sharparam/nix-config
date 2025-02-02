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
  cfg = config.${namespace}.tools.hyfetch;
in
{
  options.${namespace}.tools.hyfetch = with types; {
    enable = mkEnableOption "hyfetch";
    backend = mkOpt (enum [
      "neofetch"
      "fastfetch"
    ]) "neofetch" "The backend to use for fetching system information.";
  };

  config = mkIf cfg.enable {
    home.packages =
      with pkgs;
      [
        hyfetch
      ]
      ++ optional (cfg.backend == "fastfetch") fastfetch;

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
