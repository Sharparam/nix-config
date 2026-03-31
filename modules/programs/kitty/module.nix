{ lib, ... }:
{
  programs.kitty = {
    includes = [
      (
        { home }:
        {
          # nixpkgs Kitty crashes with an OpenGL error on non-NixOS systems
          homeManager.programs.kitty.package = lib.mkForce null;
        }
      )
    ];

    homeManager =
      { inputs', ... }:
      {
        programs.kitty = {
          enable = true;
          font = {
            package = inputs'.iosevka.packages.bin;
            name = "Iosevka Sharpie Term";
            size = 12;
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
            # direnv-instant sets `allow_remote_control` and `listen_on`
            # allow_remote_control = true;
            # listen_on = "unix:/tmp/kitty";
            envinclude = "KITTY_CONF_*";
          };
          keybindings = {
            "f1" = "show_kitty_env_vars";
            "kitty_mod+z" = "toggle_layout stack";
          };
          extraConfig = builtins.readFile ./font-nerd-symbols.conf;
        };
      };
  };
}
