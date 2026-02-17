{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.tokei;
in {
  options.${namespace}.tools.tokei = {
    enable = mkEnableOption "Enable tokei.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      tokei
    ];
  };
}
