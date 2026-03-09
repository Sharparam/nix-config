{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.podman;
in
{
  options.${namespace}.tools.podman = {
    enable = mkEnableOption "Whether or not to enable Podman.";
  };

  config = mkIf cfg.enable {
    homebrew = {
      brews = [
        "podman"
        "podman-compose"
        "podman-tui"
      ];
      casks = [ "podman-desktop" ];
    };
  };
}
