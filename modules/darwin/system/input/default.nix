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

    homebrew.casks = ["smooze-pro"];
  };
}
