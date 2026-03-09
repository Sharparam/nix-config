{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.codespelunker;
in
{
  options.${namespace}.tools.codespelunker = {
    enable = mkEnableOption "Whether or not to enable the codespelunker tool.";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.codespelunker
    ];
  };
}
