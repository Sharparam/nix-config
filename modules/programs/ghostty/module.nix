{ lib, ... }:
let
  inherit (lib) mkDefault optionals;
in
{
  programs.ghostty = {
    darwin = {
      homebrew.casks = [ "ghostty" ];
    };

    homeManager =
      { pkgs, ... }:
      let
        inherit (pkgs.stdenv) isDarwin;
        package = if isDarwin then null else pkgs.ghostty;
      in
      {
        home.sessionVariables.TERMINAL = mkDefault "ghostty";
        xdg.configFile."ghostty/tab-style.css".source = ./tab-style.css;
        systemd.user.sessionVariables.TERMINAL = mkDefault "ghostty";
        programs = {
          ghostty = {
            enable = mkDefault true;
            package = mkDefault package;
            enableZshIntegration = true;
            settings = {
              font-family = [
                "Iosevka Sharpie Term"
                "Iosevka Term"
                "Iosevka Nerd Font Mono"
                "Symbols Nerd Font Mono"
              ];
              font-size = mkDefault 12;
              # theme = "catppuccin-macchiato";
              background-opacity = 0.95;
              background-blur = false;
              shell-integration-features = [
                "ssh-terminfo"
                "ssh-env"
              ];
              quick-terminal-position = "top";
              quick-terminal-screen = "main"; # default: "main"
              # quick-terminal-animation-duration = 0;
              quick-terminal-autohide = true;
              quick-terminal-space-behavior = "move"; # default: "move"
              gtk-wide-tabs = false;
              gtk-tabs-location = "bottom";
              gtk-custom-css = "tab-style.css";
              keybind = optionals isDarwin [
                "global:ctrl+cmd+f12=toggle_quick_terminal"
              ];
            };
          };
        };
      };
  };
}
