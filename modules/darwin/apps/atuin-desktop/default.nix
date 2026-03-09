{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.${namespace}.apps.atuin-desktop;
in
{
  options.${namespace}.apps.atuin-desktop = {
    enable = lib.mkEnableOption "atuin-desktop";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "atuin-desktop" ];
  };
}
