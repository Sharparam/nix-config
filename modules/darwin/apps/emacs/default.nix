{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.emacs;
in {
  options.${namespace}.apps.emacs = with types; {
    enable = mkEnableOption "Enable emacs";
  };

  config = mkIf cfg.enable {
    homebrew = {
      taps = ["d12frosted/emacs-plus"];
      brews = [
        {
          name = "emacs-plus";
          args = ["with-native-comp"];
        }
      ];
    };
  };
}
