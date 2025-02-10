{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.spotify;
in {
  options.${namespace}.apps.spotify = with types; {
    enable = mkEnableOption "Enable Spotify.";
  };

  config = mkIf cfg.enable {
    homebrew.casks = ["spotify"];
  };
}
