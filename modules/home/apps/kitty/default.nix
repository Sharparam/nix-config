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
  cfg = config.${namespace}.apps.kitty;
in
{
  options.${namespace}.apps.kitty = {
    enable = mkEnableOption "Kitty Terminal Emulator";
  };

  config = mkIf cfg.enable {
    programs.kitty = enabled;
  };
}
