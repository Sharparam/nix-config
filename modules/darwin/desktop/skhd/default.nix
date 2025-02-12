{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.desktop.skhd;
in {
  options.${namespace}.desktop.skhd = with types; {
    enable = mkEnableOption "Enable skhd.";
    package = mkOpt package pkgs.skhd "skhd package";
    # logFile =
    #   mkOpt str "/Users/${config.${namespace}.user.name}/Library/Logs/skhd.log"
    #     "File path of log output";
  };

  config = mkIf cfg.enable {
    ${namespace}.home.extraOptions.${namespace}.cli.aliases = {
      restart-skhd = ''launchctl kickstart -k gui/"$(id -u)"/org.nixos.skhd'';
    };

    services.skhd = {
      # inherit (cfg) logFile;

      enable = true;
      package = pkgs.skhd;

      skhdConfig =
        # bash
        let
          skhd = getExe cfg.package;
          yabai = getExe config.${namespace}.desktop.yabai.package;
          sketchybar = getExe config.${namespace}.desktop.sketchybar.package;
          jq = getExe pkgs.jq;
          useYabai = config.${namespace}.desktop.yabai.enable;
          useSketchybar = config.${namespace}.desktop.sketchybar.enable;
          sb_wos =
            if useSketchybar
            then "sketchybar --trigger windows_on_spaces"
            else "true";
          goto_space = n: ''
            default < lalt - ${n} : SPACES=($(yabai -m query --displays --display | ${jq} '.spaces[]')) \
              && [[ -n $SPACES[${n}] ]] \
              && yabai -m space --focus $SPACES[${n}]
          '';
          move_window_in_space = n: ''
            default < shift + lalt - ${n} : SPACES=($(yabai -m query --displays --display | ${jq} '.spaces[]')) \
              && [[ -n $SPACES[${n}] ]] \
              && yabai -m window --space $SPACES[${n}]
          '';
        in
          # hyper: cmd + shift + alt + ctrl
          # meh: shift + alt + ctrl
          #
          # :: default : ${sketchybar} -m --set skhd icon="N" icon.color="0xff8aadf4" drawing=off
          # :: window @ : ${sketchybar} -m --set skhd icon="W" icon.color="0xffa6da95" drawing=on
          # default < ctrl - escape ; window
          # window < escape ; default
          # default < lalt - space : ${yabai} -m window --toggle float; ${sketchybar} --trigger window_focus
          ''
            ## Modes
            :: default

            ## Launchers
            default < lalt - return : kitty --single-instance -d ~
            default < shift + lalt - return : kitty -d ~
            # Experiment with ghostty
            # disable for now since it seems not quite ready yet
            # default < lalt - return : ghostty

            ## System
            default < lalt - l : osascript -e 'tell application "System Events" to keystroke "q" using {command down,control down}'
          ''
          + optionalString useYabai ''
            ## Window


            ## Navigation (lalt - ...)

            # Space navigation
            ${goto_space "1"}
            ${goto_space "2"}
            ${goto_space "3"}
            ${goto_space "4"}
            ${goto_space "5"}
            ${goto_space "6"}
            ${goto_space "7"}
            ${goto_space "8"}
            ${goto_space "9"}

            # Window navigation
            default < lalt - h : yabai -m window --focus west || yabai -m display --focus west
            default < lalt - j : yabai -m window --focus south || yabai -m display --focus south
            default < lalt - k : yabai -m window --focus north || yabai -m display --focus north
            default < lalt - l : yabai -m window --focus east || yabai -m display --focus east
            # Extended
            default < lalt - g : yabai -m window --focus first
            default < lalt - ; : yabai -m window --focus last

            # Toggle floating window
            default < lalt - space : yabai -m window --toggle float

            # Make window zoom to fullscreen
            default < shift + lalt - f : yabai -m window --toggle zoom-fullscreen

            # Make window zoom to parent node
            default < lalt - f : yabai -m window --toggle zoom-parent

            # Window movement
            # Moving windows in(side) spaces:
            # Temporarily removed the following addition:
            # && ${sb_wos} \
            # (to put back, put after the first call to yabai in each keybind in this section)
            default < shift + lalt - h : yabai -m window --warp west \
              || $( \
                yabai -m window --display west \
                && yabai -m display --focus west \
                && yabai -m window --warp last) \
              || yabai -m window --move rel:-10:0
            default < shift + lalt - j : yabai -m window --warp south \
              || $( \
                yabai -m window --display south \
                && yabai -m display --focus south \
                && yabai -m window --warp last) \
              || yabai -m window --move rel:0:10
            default < shift + lalt - k : yabai -m window --warp north \
              || $( \
                yabai -m window --display north \
                && yabai -m display --focus north \
                && yabai -m window --warp last) \
              || yabai -m window --move rel:0:-10
            default < shift + lalt - l : yabai -m window --warp east \
              || $( \
                yabai -m window --display east \
                && yabai -m display --focus east \
                && yabai -m window --warp last) \
              || yabai -m window --move rel:10:0

            # Window resizing
            default < ctrl + lalt - h : yabai -m window --resize right:-100:0 || yabai -m window --resize left:-100:0
            default < ctrl + lalt - j : yabai -m window --resize bottom:0:100 || yabai -m window --resize top:0:100
            default < ctrl + lalt - k : yabai -m window --resize bottom:0:-100 || yabai -m window --resize top:0:-100
            default < ctrl + lalt - l : yabai -m window --resize right:100:0 || yabai -m window --resize left:100:0

            # Equalize window size
            default < ctrl + lalt - e : yabai -m space --balance

            # Toggle padding and gaps
            default < ctrl + lalt - g : yabai -m space --toggle padding; yabai -m space --toggle gap

            # Move windows between spaces
            ${move_window_in_space "1"}
            ${move_window_in_space "2"}
            ${move_window_in_space "3"}
            ${move_window_in_space "4"}
            ${move_window_in_space "5"}
            ${move_window_in_space "6"}
            ${move_window_in_space "7"}
            ${move_window_in_space "8"}
            ${move_window_in_space "9"}
            default < shift + lalt - p : yabai -m window --space prev && yabai -m space --focus prev
            default < shift + lalt - n : yabai -m window --space next && yabai -m space --focus next

            # Mirror space on X and Y axis
            default < shift + lalt - x : yabai -m space --mirror x-axis
            default < shift + lalt - y : yabai -m space --mirror y-axis

            ## Layout

            default < shift + lalt - z : yabai -m space --layout bsp
            default < shift + lalt - x : yabai -m space --layout stack
            default < shift + lalt - c : yabai -m space --layout float

            ## Stacks

            # Add active window to window or stack to direction
            default < shift + ctrl - h : yabai -m window west --stack $(yabai -m query --windows --window | ${jq} -r '.id')
            default < shift + ctrl - j : yabai -m window south --stack $(yabai -m query --windows --window | ${jq} -r '.id')
            default < shift + ctrl - k : yabai -m window north --stack $(yabai -m query --windows --window | ${jq} -r '.id')
            default < shift + ctrl - l : yabai -m window east --stack $(yabai -m query --windows --window | ${jq} -r '.id')

            # Stack navigation
            default < shift + ctrl - n : yabai -m window --focus stack.next
            default < shift + ctrl - p : yabai -m window --focus stack.prev

            ## Insertions

            # Set insertion point for focused container
            default < shift + ctrl + lalt - h : yabai -m window --insert west
            default < shift + ctrl + lalt - j : yabai -m window --insert south
            default < shift + ctrl + lalt - k : yabai -m window --insert north
            default < shift + ctrl + lalt - l : yabai -m window --insert east
            default < shift + ctrl + lalt - s : yabai -m window --insert stack

            # New window in horizontal/vertical splits for all applications with yabai
            default < lalt - s : yabai -m window --insert east; skhd -k "cmd - n"
            default < lalt - v : yabai -m window --insert south; skhd -k "cmd - n"
          ''
          + optionalString useSketchybar ''
            # Toggle sketchybar (b = bar)
            default < meh - b : sketchybar --bar hidden=toggle
          '';
    };

    # https://github.com/koekeishiya/skhd/issues/342
    system.activationScripts.postActivation.text = ''
      echo "Restarting skhd..."
      launchctl kickstart -k gui/"$(id -u ${config.${namespace}.user.name})"/org.nixos.skhd
    '';
  };
}
