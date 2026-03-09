{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.apps.google.chrome;
in
{
  options.${namespace}.apps.google.chrome = {
    enable = mkEnableOption "Google Chrome";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "google-chrome" ];
  };
}
