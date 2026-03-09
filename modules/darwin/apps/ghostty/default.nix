{
  lib,
  namespace,
  config,
  ...
}:
let
  cfg = config.${namespace}.apps.ghostty;
in
{
  options.${namespace}.apps.ghostty = {
    enable = lib.mkEnableOption "ghostty";
  };

  config = lib.mkIf cfg.enable {
    homebrew.casks = [ "ghostty" ];
  };
}
