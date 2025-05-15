{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.podman;
in {
  options.${namespace}.tools.podman = with types; {
    enable = mkEnableOption "Whether or not to enable Podman.";
  };

  config = mkIf cfg.enable {
    homebrew = {
      brews = [
        "podman"
        "podman-compose"
        "podman-tui"
      ];
      casks = ["podman-desktop"];
    };
  };
}
