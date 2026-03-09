{
  lib,
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
    fontPackage = mkOption {
      type = nullOr package;
      default = inputs.iosevka.packages.${system}.bin;
      description = "Font package to use.";
    };
    fontName = mkOption {
      type = nullOr str;
      default = "Iosevka Sharpie Term";
      description = "Font name to use.";
    };
    fontSize = mkOption {
      type = nullOr number;
      default = 12;
      description = "Font size to use.";
    };
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
      extraConfig = builtins.readFile ../../../../dotfiles/kitty/.config/kitty/font-nerd-symbols.conf;
    };
  };
}
