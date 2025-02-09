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
            then "${sketchybar} --trigger windows_on_spaces"
            else "true";
        in
          # hyper: cmd + shift + alt + ctrl
          # meh: shift + alt + ctrl
          (
            if useSketchybar
            then ''
              ## Modes
              :: default : ${sketchybar} -m --set skhd icon="N" icon.color="0xff8aadf4" drawing=off
              :: window @ : ${sketchybar} -m --set skhd icon="W" icon.color="0xffa6da95" drawing=on

              default < ctrl - escape ; window
              window < escape ; default

              # Toggle floating window
              default < lalt - space : ${yabai} -m window --toggle float; ${sketchybar} --trigger window_focus
            ''
            else ''
              ## Modes
              :: default

              # Toggle floating window
              default < lalt - space : ${yabai} -m window --toggle float
            ''
          )
          + ''
            ## Launchers
            default < cmd - return : ${getExe pkgs.kitty} --single-instance -d ~
            default < shift + cmd - return : ${getExe pkgs.kitty} -d ~

            ## System
            default < cmd - l : osascript -e 'tell application "System Events" to keystroke "q" using {command down,control down}'
          ''
          + optionalString useYabai ''
            ## Window

            # Window navigation
            default < lalt - h : ${yabai} -m window --focus west || ${yabai} -m display --focus west
            default < lalt - j : ${yabai} -m window --focus south || ${yabai} -m display --focus south
            default < lalt - k : ${yabai} -m window --focus north || ${yabai} -m display --focus north
            default < lalt - l : ${yabai} -m window --focus east || ${yabai} -m display --focus east

            # Window movement
            default < shift + lalt - h : ${yabai} -m window --warp west \
              || $( \
                ${yabai} -m window --display west \
                && ${sb_wos} \
                && ${yabai} -m display --focus west \
                && ${yabai} -m window --warp last) \
              || ${yabai} -m window --move rel:-10
            default < shift + lalt - j : ${yabai} -m window --warp south \
              || $( \
                ${yabai} -m window --display south \
                && ${sb_wos} \
                && ${yabai} -m display --focus south \
                && ${yabai} -m window --warp last) \
              || ${yabai} -m window --move rel:0:10
            default < shift + lalt - k : ${yabai} -m window --warp north \
              || $( \
                ${yabai} -m window --display north \
                && ${sb_wos} \
                && ${yabai} -m display --focus north \
                && ${yabai} -m window --warp last) \
              || ${yabai} -m window --move rel:0:-10
            default < shift + lalt - l : ${yabai} -m window --warp east \
              || $( \
                ${yabai} -m window --display east \
                && ${sb_wos} \
                && ${yabai} -m display --focus east \
                && ${yabai} -m window --warp last) \
              || ${yabai} -m window --move rel:10

            # Window resizing
            default < ctrl + lalt - h : ${yabai} -m window --resize right:-100:0 || ${yabai} -m window --resize left:-100:0
            default < ctrl + lalt - j : ${yabai} -m window --resize bottom:0:100 || ${yabai} -m window --resize top:0:100
            default < ctrl + lalt - k : ${yabai} -m window --resize bottom:0:-100 || ${yabai} -m window --resize top:0:-100
            default < ctrl + lalt - l : ${yabai} -m window --resize right:100:0 || ${yabai} -m window --resize left:100:0

            # Equalize window size
            default < ctrl + lalt - e : ${yabai} -m space --balance

            # Toggle padding and gaps
            default < ctrl + lalt - g : ${yabai} -m space --toggle padding; ${yabai} -m space --toggle gap

            # Move windows between spaces
            default < shift + lalt - 1 : SPACES=($(${yabai} -m query --displays --display | ${jq} '.spaces[]')) \
              && [[ -n $SPACES[1] ]] \
              && ${yabai} -m window --space $SPACES[1]
            default < shift + lalt - 2 : SPACES=($(${yabai} -m query --displays --display | ${jq} '.spaces[]')) \
              && [[ -n $SPACES[2] ]] \
              && ${yabai} -m window --space $SPACES[2]
            default < shift + lalt - 3 : SPACES=($(${yabai} -m query --displays --display | ${jq} '.spaces[]')) \
              && [[ -n $SPACES[3] ]] \
              && ${yabai} -m window --space $SPACES[3]
            default < shift + lalt - 4 : SPACES=($(${yabai} -m query --displays --display | ${jq} '.spaces[]')) \
              && [[ -n $SPACES[4] ]] \
              && ${yabai} -m window --space $SPACES[4]
            default < shift + lalt - 5 : SPACES=($(${yabai} -m query --displays --display | ${jq} '.spaces[]')) \
              && [[ -n $SPACES[5] ]] \
              && ${yabai} -m window --space $SPACES[5]
            default < shift + lalt - 6 : SPACES=($(${yabai} -m query --displays --display | ${jq} '.spaces[]')) \
              && [[ -n $SPACES[6] ]] \
              && ${yabai} -m window --space $SPACES[6]
            default < shift + lalt - 7 : SPACES=($(${yabai} -m query --displays --display | ${jq} '.spaces[]')) \
              && [[ -n $SPACES[7] ]] \
              && ${yabai} -m window --space $SPACES[7]
            default < shift + lalt - 8 : SPACES=($(${yabai} -m query --displays --display | ${jq} '.spaces[]')) \
              && [[ -n $SPACES[8] ]] \
              && ${yabai} -m window --space $SPACES[8]
            default < shift + lalt - 9 : SPACES=($(${yabai} -m query --displays --display | ${jq} '.spaces[]')) \
              && [[ -n $SPACES[9] ]] \
              && ${yabai} -m window --space $SPACES[9]

            ## Layout

            default < shift + lalt - z : ${yabai} -m space --layout bsp
            default < shift + lalt - x : ${yabai} -m space --layout stack
            default < shift + lalt - c : ${yabai} -m space --layout float
          ''
          + optionalString useSketchybar ''
            # Toggle sketchybar (b = bar)
            default < meh - b : ${sketchybar} --bar hidden=toggle
          '';
    };

    # https://github.com/koekeishiya/skhd/issues/342
    system.activationScripts.postActivation.text = ''
      echo "Restarting skhd..."
      launchctl kickstart -k gui/"$(id -u ${config.${namespace}.user.name})"/org.nixos.skhd
    '';
  };
}
