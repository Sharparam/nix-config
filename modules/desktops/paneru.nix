# Paneru, like Niri but for macOS
# https://github.com/karinushka/paneru
{ inputs, lib, ... }:
let
  # Try to mimic Niri keybinds
  mod = "alt";
  super = "cmd";
  movement = mod;
  mutate = "${movement} + ctrl";
  bindings = {
    # Moves the focus between windows. If there are no windows when moving up or
    # down, will swtich focus to the display above or below.
    window_focus_west = [
      "${movement} - h"
      "${movement} - leftarrow"
    ];
    window_focus_east = [
      "${movement} - l"
      "${movement} - rightarrow"
    ];
    window_focus_north = [
      "${movement} - k"
      "${movement} - uparrow"
    ];
    window_focus_south = [
      "${movement} - j"
      "${movement} - downarrow"
    ];

    # Swaps windows in chosen direction. If there are no windows to swap, will
    # move the window to a display above or below.
    window_swap_west = "${mutate} - h";
    window_swap_east = "${mutate} - l";
    window_swap_north = "${mutate} - k";
    window_swap_south = "${mutate} - j";

    # Jump to the left-most or right-most windows.
    window_focus_first = [
      "${movement} + shift - h"
      "${movement} + shift - leftarrow"
    ];
    window_focus_last = [
      "${movement} + shift - l"
      "${movement} + shift - rightarrow"
    ];

    # Move the current window into the left-most or right-most positions.
    window_swap_first = "${mutate} + shift - h";
    window_swap_last = "${mutate} + shift - l";

    # Centers the current window on screen.
    window_center = "${mutate} - c";

    # Cycles between the window sizes defined in the `preset_column_widths` option.
    window_resize = "${mutate} - r";

    # Cycles backwards through `preset_column_widths`.
    window_shrink = "${mutate} + shift - r";

    # Toggle full width for the current focused window.
    window_fullwidth = "${mutate} - f";

    # Toggles the window for management. If unmanaged, the window will be "floating".
    window_manage = [
      "ctrl + alt - t"
      "ctrl + alt - space"
    ];

    # Stacks and unstacks a window into the left column. Each window gets a 1/N of the height.
    window_stack = "${mutate} - [";
    window_unstack = [
      "${mutate} + shift - ["
      "${mutate} - ]"
    ];

    # Moves currently focused window to the next display.
    window_nextdisplay = "${mutate} - n";

    # Moves the mouse pointer to the next display.
    mouse_nextdisplay = "${movement} - n";

    # Size stacked windows in the column to equal heights.
    window_equalize = "${mutate} - e";

    # Quits the window manager.
    quit = "cmd + ctrl + alt + shift - q";
  };
in
{
  flake-file.inputs.paneru = {
    url = "github:karinushka/paneru";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.desktops.provides.paneru = {
    homeManager =
      { pkgs, ... }:
      lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
        imports = [ inputs.paneru.homeModules.paneru ];

        services.paneru = {
          # Issues with Ghostty, so disable for now
          # https://github.com/karinushka/paneru/issues/93
          enable = lib.mkDefault false; # pkgs.stdenv.hostPlatform.isDarwin;
          settings = {
            inherit bindings;

            options = { };
          };
        };
      };
  };
}
