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
    mkPackageOption
    ;
  cfg = config.${namespace}.desktop.skhd;
in
{
  options.${namespace}.desktop.skhd = {
    enable = mkEnableOption "skhd";
    package = mkPackageOption pkgs "skhd";
    # logFile = mkOption {
    #   type = str;
    #   default = "/Users/${config.${namespace}.user.name}/Library/Logs/skhd.log";
    #   description = "File path of log output";
    # };
  };

  config = mkIf cfg.enable {
    ${namespace}.home.extraOptions.programs = {
      bash.initExtra = ''
        restart-skhd() {
          launchctl kickstart -k gui/"$(id -u)"/org.nixos.skhd
        }
      '';

      zsh.siteFunctions = {
        restart-skhd = ''
          launchctl kickstart -k gui/"$(id -u)"/org.nixos.skhd
        '';
      };
    };

    services.skhd = {
      # inherit (cfg) logFile;

      enable = true;
      package = pkgs.skhd;

      skhdConfig =
        # bash
        # hyper: cmd + shift + alt + ctrl
        # meh: shift + alt + ctrl
        #
        # default < ctrl - escape ; window
        # window < escape ; default
        ''
          ## Modes
          :: default

          ## Launchers
          # default < lalt - return : kitty --single-instance -d ~
          # default < shift + lalt - return : kitty -d ~
          # Experiment with ghostty
          # adding --new to open a new instance breaks the quick terminal
          default < lalt - return : open -a ghostty --args --quit-after-last-window-closed=true

          ## System
          # default < lalt - l : osascript -e 'tell application "System Events" to keystroke "q" using {command down,control down}'
        '';
    };

    # https://github.com/koekeishiya/skhd/issues/342
    system.activationScripts.postActivation.text = ''
      echo "Restarting skhd..."
      launchctl kickstart -k gui/"$(id -u ${config.${namespace}.user.name})"/org.nixos.skhd
    '';
  };
}
