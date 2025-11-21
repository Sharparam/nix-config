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
    fontSize = mkOpt int 12 "Font size";
  };

  config = mkIf cfg.enable {
    home.sessionVariables = mkIf cfg.setAsDefault {
      TERMINAL = mkDefault "ghostty";
    };
    programs.ghostty = {
      enable = true;
      # nix package/flake not supported on darwin:
      # https://github.com/ghostty-org/ghostty/discussions/2824
      package =
        if pkgs.stdenv.isDarwin
        then null
        else pkgs.ghostty;
      enableZshIntegration = true;
      settings = {
        font-family = [
          "Iosevka Sharpie Term"
          "Iosevka Term"
          "Iosevka Nerd Font Mono"
          "Symbols Nerd Font Mono"
        ];
        font-size = cfg.fontSize;
        # theme = "catppuccin-macchiato";
        background-opacity = 0.95;
        background-blur = false;
        shell-integration-features = ["ssh-terminfo" "ssh-env"];
        quick-terminal-position = "top";
        quick-terminal-screen = "main"; # default: "main"
        # quick-terminal-animation-duration = 0;
        quick-terminal-autohide = true;
        quick-terminal-space-behavior = "move"; # default: "move"
        keybind =
          [
          ]
          ++ optionals pkgs.stdenv.isDarwin [
            "global:ctrl+cmd+f12=toggle_quick_terminal"
          ];
      };
    };
  };
}
