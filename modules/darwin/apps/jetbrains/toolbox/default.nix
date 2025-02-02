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
  cfg = config.${namespace}.apps.jetbrains.toolbox;
in
{
  options.${namespace}.apps.jetbrains.toolbox = with types; {
    enable = mkEnableOption "JetBrains Toolbox";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      jetbrains-toolbox
    ];
  };
}
