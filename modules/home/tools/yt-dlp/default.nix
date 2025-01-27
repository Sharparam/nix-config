{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.yt-dlp;
in
{
  options.${namespace}.tools.yt-dlp = {
    enable = mkEnableOption "yt-dlp";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      yt-dlp
    ];
  };
}
