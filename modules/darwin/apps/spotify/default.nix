{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.apps.spotify;
in
{
  options.${namespace}.apps.spotify = {
    enable = mkEnableOption "Spotify";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "spotify" ];
  };
}
