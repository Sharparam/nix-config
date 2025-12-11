{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.sweet-home3d;
in {
  options.${namespace}.apps.sweet-home3d = with types; {
    enable = mkEnableOption "Sweet Home 3D";
  };

  config = mkIf cfg.enable {
    homebrew = {
      casks = ["sweet-home3d"];
    };
  };
}
