{
  lib,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.apps.ghostty;
in
{
  options.${namespace}.apps.ghostty = with types; {
    enable = mkEnableOption "ghostty";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "ghostty" ];
  };
}
