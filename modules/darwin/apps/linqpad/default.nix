{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.apps.linqpad;
in
{
  options.${namespace}.apps.linqpad = {
    enable = mkEnableOption "LINQPad";
  };

  config = mkIf cfg.enable {
    environment.systemPackages =
      let
        net9 = pkgs.dotnetCorePackages.sdk_9_0;
        net8 = pkgs.dotnetCorePackages.sdk_8_0;
      in
      [
        (pkgs.combinePackages [
          net9
          net8
        ])
      ];
  };
}
