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
  cfg = config.${namespace}.tools.codespelunker;
in
{
  options.${namespace}.tools.codespelunker = with types; {
    enable = mkEnableOption "Whether or not to enable the codespelunker tool.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      codespelunker
    ];
  };
}
