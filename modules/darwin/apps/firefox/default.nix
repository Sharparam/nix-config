{
  lib,
  pkgs,
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
    enable = mkEnableOption "Enable Firefox.";
    enableDeveloperEdition = mkBoolOpt false "Enable Firefox Developer Edition.";
  };

  config = mkIf cfg.enable {
    homebrew = {
      casks = [ "firefox" ] ++ optional cfg.enableDeveloperEdition [ "firefox-developer-edition" ];
    };
  };
}
