{
  lib,
  pkgs,
  namespace,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.ffmpeg;
in {
  options.${namespace}.tools.ffmpeg = {
    enable = mkEnableOption "ffmpeg";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ffmpeg-full
    ];
  };
}
