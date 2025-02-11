{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.ghostty;
in {
  options.${namespace}.apps.ghostty = with types; {
    enable = mkEnableOption "Enable ghostty.";
    setAsDefault = mkBoolOpt false "Set ghostty as default terminal (TERMINAL env var).";
  };

  config = mkIf cfg.enable {
    home.sessionVariables = mkIf cfg.setAsDefault {
      TERMINAL = mkDefault "ghostty";
    };
    programs.ghostty = {
      enable = true;
      settings = {
        font-family = [
          "Iosevka Sharpie Term"
          "Iosevka Term"
          "Iosevka Nerd Font Mono"
          "Symbols Nerd Font"
        ];
        font-size = 12;
        # theme = "catppuccin-macchiato";
        background-opacity = 0.95;
        background-blur = false;
        quick-terminal-position = "top";
        quick-terminal-screen = "main"; # default: "main"
        # quick-terminal-animation-duration = 0;
        quick-terminal-autohide = true;
        quick-terminal-space-behavior = "move"; # default: "move"
        keybind =
          [
          ]
          ++ optionals pkgs.stdenv.isDarwin [
            "global:cmd+f12=toggle_quick_terminal"
          ];
      };
    };
  };
}
