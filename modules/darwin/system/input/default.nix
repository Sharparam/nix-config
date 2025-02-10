{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.system.input;
in {
  options.${namespace}.system.input = with types; {
    enable = mkEnableOption "Whether or not to enable the input system.";
  };

  config = mkIf cfg.enable {
    system = {
      keyboard = {
        enableKeyMapping = true;
        # remapCapsLockToControl = false;
        remapCapsLockToEscape = true;
        # swapLeftCommandAndLeftAlt = false;
        # swapLeftCtrlAndFn = false;

        nonUS.remapTilde = true;

        userKeyMapping = [
          # The reverse of remapTilde, not exposed as a convenient option for us
          # This lets us still have access to the original key behaviour
          {
            HIDKeyboardModifierMappingSrc = 30064771125;
            HIDKeyboardModifierMappingDst = 30064771172;
          }
        ];
      };

      defaults = {
        NSGlobalDomain = {
          AppleKeyboardUIMode = 3;

          NSAutomaticCapitalizationEnabled = false;
          NSAutomaticDashSubstitutionEnabled = false;
          NSAutomaticPeriodSubstitutionEnabled = false;
          NSAutomaticQuoteSubstitutionEnabled = false;
          NSAutomaticSpellingCorrectionEnabled = false;
        };
      };
    };

    homebrew.casks = ["smooze-pro" "steermouse"];
  };
}
