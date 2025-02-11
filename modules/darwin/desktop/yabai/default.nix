{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.desktop.yabai;
  useSketchybar = config.${namespace}.desktop.sketchybar.enable;
in {
  options.${namespace}.desktop.yabai = with types; {
    enable = mkEnableOption "Enable yabai.";
    package = mkOpt package pkgs.yabai "yabai package";
    debug = mkBoolOpt false "Whether to enable debug output";
    # logFile =
    #   mkOpt str "/Users/${config.${namespace}.user.name}/Library/Logs/yabai.log"
    #     "File path of log output";
    spacesCount = mkOpt int 9 "Number of spaces";
    enableSpaceId = mkBoolOpt (!useSketchyBar) "Whether to enable SpaceId";
  };

  config = mkIf cfg.enable {
    ${namespace}.home.extraOptions.${namespace}.cli.aliases = {
      restart-yabai = ''launchctl kickstart -k gui/"$(id -u)"/org.nixos.yabai'';
    };

    homebrew.casks = mkIf cfg.enableSpaceId ["spaceid"];

    services.yabai = {
      # inherit (cfg) logFile;

      enable = true;
      package = cfg.package;
      enableScriptingAddition = true;

      # https://github.com/koekeishiya/yabai/wiki/Configuration#configuration-file
      # https://github.com/koekeishiya/yabai/blob/master/doc/yabai.asciidoc#config
      # everything is string for some reason
      # bools are "on" or "off"
      config = {
        ## Global settings

        debug_output =
          if cfg.debug
          then "on"
          else "off";

        # external_bar = "off"; # default: "off"?
        menubar_opacity =
          if useSketchybar
          then "0.5"
          else "1.0"; # default: "1.0"

        mouse_follows_focus = "off"; # default: "off"
        focus_follows_mouse = "autoraise"; # default: "off"

        # display_arrangement_order = "default";

        window_origin_display = "focused"; # default: "default"?
        window_placement = "second_child"; # default: "second_child"
        # window_insertion_point = "focused";
        # window_zoom_persist = "on";
        window_shadow = "float"; # default: "on"
        window_opacity = "on"; # default: "off"
        # window_opacity_duration = "0.5";
        active_window_opacity = "1.0"; # default: "1.0"?
        normal_window_opacity = "0.9"; # default: "1.0"?
        # window_animation_duration = "0.0";
        # window_animation_easing = ""; # https://easings.net/
        # insert_feedback_color = ""; # 0xAARRGGBB
        split_ratio = "0.5"; # default: "0.5"

        mouse_modifier = "fn"; # default: "fn"
        mouse_action1 = "move"; # default: "move"
        mouse_action2 = "resize"; # default: "resize"
        mouse_drop_action = "swap"; # default: "swap"?

        ## Space settings

        layout = "bsp"; # default: "float"
        split_type = "auto"; # default: "auto"?

        # All padding (including gap) defaults to "0"
        # top_padding = "0";
        # bottom_padding = "0";
        # left_padding = "0";
        # right_padding = "0";
        # window_gap = "0";

        auto_balance = "off"; # default: "off"
      };

      extraConfig =
        # bash
        let
          yabai = getExe cfg.package;
          yabai-helper = getExe pkgs.${namespace}.yabai-helper;
          sketchybar = getExe config.${namespace}.desktop.sketchybar.package;
          jq = getExe pkgs.jq;
        in
          ''
            echo "yabai configuration loading"

            ${builtins.readFile ./extraConfig}

            # Signal hooks
            ${yabai} -m signal --add event=dock_did_restart action="sudo ${yabai} --load-sa"
            ${yabai} -m signal --add event=display_added action="sleep 1 && source ${yabai-helper} && create_spaces ${cfg.spacesCount}"
            ${yabai} -m signal --add event=display_removed action="sleep 1 && source ${yaba-helper} && create_spaces ${cfg.spacesCount}"

            echo "yabai configuration loaded"
          ''
          + optionalString useSketchybar ''
            echo "yabai sketchybar integration loading"

            BAR_HEIGHT=$(${sketchybar} -m --query bar | ${jq} -r '.height')
            echo "bar height is $BAR_HEIGHT"
            ${yabai} -m config external_bar all:"$BAR_HEIGHT":0

            ${yabai} -m signal --add event=window_focused action="${sketchybar} --trigger window_focus"
            ${yabai} -m signal --add event=window_created action="${sketchybar} --trigger windows_on_spaces"
            ${yabai} -m signal --add event=window_destroyed action="${sketchybar} --trigger windows_on_spaces"

            echo "yabai sketchybar integration loaded"
          '';
    };
  };
}
