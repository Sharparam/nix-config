{
  den.aspects.apps.provides.skhd = {
    includes = [
      (
        { host, user }:
        {
          darwin = {
            system.activationScripts.postActivation.text = ''
              echo "Restarting skhd..."
              launchctl kickstart -k gui/"$(id -u ${user.name})"/org.nixos.skhd
            '';
          };
        }
      )
    ];

    darwin = _: {
      services.skhd = {
        enable = true;

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
    };

    homeManager = {
      programs = {
        bash.initExtra = ''
          restart-skhd() {
            launchctl kickstart -k gui/"$(id -u)"/org.nixos.skhd
          }
        '';

        zsh.siteFunctions.restart-skhd = ''
          launchctl kickstart -k gui/"$(id -u)"/org.nixos.skhd
        '';
      };
    };
  };
}
