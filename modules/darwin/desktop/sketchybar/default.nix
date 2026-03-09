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
    mkPackageOption
    types
    ;
  cfg = config.${namespace}.desktop.sketchybar;
in
{
  options.${namespace}.desktop.sketchybar = {
    enable = mkEnableOption "sketchybar";
    package = mkPackageOption pkgs "sketchybar";
    # logFile = mkOption {
    #   type = str;
    #   default = "/Users/${config.${namespace}.user.name}/Library/Logs/sketchybar.log";
    #   description = "File path of log output";
    # };
    catppuccinFlavor = mkOption {
      type = types.str;
      default = "frappe";
      description = "Catppuccin flavor for colors.";
    };
  };

  config = mkIf cfg.enable {
    ${namespace}.home = {
      extraOptions.programs = {
        bash.initExtra = ''
          restart-sketchybar() {
            launchctl kickstart -k gui/"$(id -u)"/org.nixos.sketchybar
          }
        '';

        zsh.siteFunctions = {
          restart-sketchybar = ''
            launchctl kickstart -k gui/"$(id -u)"/org.nixos.sketchybar
          '';
        };
      };

      configFile."sketchybar".source = ./config;
    };

    services.sketchybar = {
      # inherit (cfg) logFile;

      enable = true;
      inherit (cfg) package;

      extraPackages = [
        pkgs.jq
        (pkgs.lua5_4.withPackages (ps: [ ps.snix.sbarlua ]))
        pkgs.snix.sketchyhelper
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
