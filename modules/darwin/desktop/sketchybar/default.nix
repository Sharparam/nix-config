{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.desktop.sketchybar;
in {
  options.${namespace}.desktop.sketchybar = with types; {
    enable = mkEnableOption "Enable sketchybar.";
    package = mkOpt package pkgs.sketchybar "sketchybar package";
    # logFile =
    #   mkOpt str "/Users/${config.${namespace}.user.name}/Library/Logs/sketchybar.log"
    #     "File path of log output";
    catppuccinFlavor = mkOpt str "frappe" "Catppuccin flavor for colors.";
  };

  config = mkIf cfg.enable {
    ${namespace}.home = {
      extraOptions.${namespace}.cli.aliases = {
        restart-sketchybar = ''launchctl kickstart -k gui/"$(id -u)"/org.nixos.sketchybar'';
      };

      configFile."sketchybar".source = ./config;
    };

    services.sketchybar = {
      # inherit (cfg) logFile;

      enable = true;
      package = cfg.package;

      extraPackages = with pkgs; [
        jq
        (lua5_4.withPackages (ps: with ps; [ snix.sbarlua ]))
        snix.sketchyhelper
      ];

      # Config files managed via symlinks for now
      # config =
      #   let
      #     sketchybar = getExe cfg.package;
      #     icon-map = getExe pkgs.sketchybar-app-font;
      #   in
      #   ''
      #     echo "sketchybar configuration loading"

      #     PLUGIN_DIR="$CONFIG_DIR/plugins"

      #     ${builtins.readFile ./colors/catppuccin_ + "${cfg.catppuccinFlavor}.sh"}
      #     ${builtins.readFile ./colors/colors.sh}

      #     source ${icon-map}
      #     function echo_icon() {
      #       __icon_map "$1"
      #       echo "$icon_result"
      #     }

      #     ${builtins.readFile ./icons.sh}

      #     ${builtins.readFile ./sketchybarrc}

      #     ${sketchybar} --update

      #     echo "sketchybar configuration loaded"
      #   '';
    };
  };
}
