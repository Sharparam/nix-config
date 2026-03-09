{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.tokei;
in
{
  options.${namespace}.tools.tokei = {
    enable = mkEnableOption "tokei";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.tokei
    ];
  };
}
