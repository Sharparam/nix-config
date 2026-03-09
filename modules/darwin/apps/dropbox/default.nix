{
  lib,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.apps.dropbox;
in
{
  options.${namespace}.apps.dropbox = with types; {
    enable = mkEnableOption "Dropbox";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "dropbox" ];
  };
}
