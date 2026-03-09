{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    optional
    types
    ;
  cfg = config.${namespace}.apps.firefox;
in
{
  options.${namespace}.apps.firefox = {
    enable = mkEnableOption "Firefox";
    enableDeveloperEdition = mkOption {
      type = types.bool;
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
