{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.apps.obs;
in
{
  options.${namespace}.apps.obs = {
    enable = mkEnableOption "OBS";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "obs" ];
  };
}
