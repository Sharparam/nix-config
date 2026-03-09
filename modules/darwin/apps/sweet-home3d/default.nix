{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.apps.sweet-home3d;
in
{
  options.${namespace}.apps.sweet-home3d = {
    enable = mkEnableOption "Sweet Home 3D";
  };

  config = mkIf cfg.enable {
    homebrew = {
      casks = [ "sweet-home3d" ];
    };
  };
}
