{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.${namespace}.apps.dropbox;
in
{
  options.${namespace}.apps.dropbox = {
    enable = lib.mkEnableOption "Dropbox";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "dropbox" ];
  };
}
