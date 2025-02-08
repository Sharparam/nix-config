{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.tools.asciinema;
in
{
  options.${namespace}.tools.asciinema = with types; {
    enable = mkEnableOption "Whether or not to enable the asciinema tool.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      asciinema
    ];
  };
}
