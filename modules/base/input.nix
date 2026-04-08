{ lib, ... }:
{
  den.aspects.base = {
    nixos = {
      console.useXkbConfig = true;
      services.xserver.xkb = {
        layout = lib.mkDefault "eu";
        variant = "";
        # variant = "altgr-intl";
        options = lib.mkDefault "caps:escape_shifted_compose,compose:rwin";
      };
    };

    darwin = {
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
            ApplePressAndHoldEnabled = false;

            NSAutomaticCapitalizationEnabled = false;
            NSAutomaticDashSubstitutionEnabled = false;
            NSAutomaticPeriodSubstitutionEnabled = false;
            NSAutomaticQuoteSubstitutionEnabled = false;
            NSAutomaticSpellingCorrectionEnabled = false;
          };
        };
      };
    };
  };
}
