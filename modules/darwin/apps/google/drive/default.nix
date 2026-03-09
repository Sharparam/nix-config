{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.apps.google.drive;
in
{
  options.${namespace}.apps.google.drive = {
    enable = mkEnableOption "Google Drive";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "google-drive" ];
  };
}
