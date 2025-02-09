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
  cfg = config.${namespace}.apps.google.drive;
in
{
  options.${namespace}.apps.google.drive = with types; {
    enable = mkEnableOption "Enable Google Drive.";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "google-drive" ];
  };
}
