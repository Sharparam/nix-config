{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.asciinema;
in
{
  options.${namespace}.tools.asciinema = {
    enable = mkEnableOption "Whether or not to enable the asciinema tool.";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.asciinema
    ];
  };
}
