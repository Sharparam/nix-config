{
  lib,
  pkgs,
  inputs,
  namespace,
  system,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.apps.kitty;
in
{
  options.${namespace}.apps.kitty = with types; {
    enable = mkEnableOption "Kitty Terminal Emulator";
    fontPackage = mkOpt (nullOr package) inputs.iosevka.packages.${system}.bin "Font package to use.";
    fontName = mkOpt (nullOr str) "Iosevka Sharpie Term" "Font name to use.";
    fontSize = mkOpt (nullOr str) "12" "Font size to use.";
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      font = {
        package = cfg.fontPackage;
        name = cfg.fontName;
        size = cfg.fontSize;
      };
      shellIntegration = {
        mode = "no-cursor";
      };
      settings = {
        disable_ligatures = "never";
        cursor_shape = "block";
        wheel_scroll_multiplier = 5;
        wheel_scroll_min_lines = 1;
        enable_audio_bell = false;
        bell_on_tab = "🔔 ";
        remember_window_size = true;
        initial_window_width = "120c";
        initial_window_height = "30c";
        enabled_layouts = "*";
        tab_bar_style = "powerline";
        tab_powerline_style = "angled";
        tab_activity_symbol = "* ";
        background_opacity = 0.95;
        allow_remote_control = true;
        listen_on = "unix:/tmp/kitty";
        envinclude = "KITTY_CONF_*";
      };
      keybindings = {
        "f1" = "show_kitty_env_vars";
        "kitty_mod+z" = "toggle_layout stack";
      };
    };
  };
}
