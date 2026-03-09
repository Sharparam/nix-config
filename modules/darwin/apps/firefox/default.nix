{
  lib,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.apps.firefox;
in
{
  options.${namespace}.apps.firefox = with types; {
    enable = mkEnableOption "Firefox";
    enableDeveloperEdition = mkOption {
      type = bool;
      default = false;
      description = "Enable Firefox Developer Edition.";
    };
  };

  config = mkIf cfg.enable {
    homebrew = {
      casks = [ "firefox" ] ++ optional cfg.enableDeveloperEdition [ "firefox-developer-edition" ];
    };
  };
}
