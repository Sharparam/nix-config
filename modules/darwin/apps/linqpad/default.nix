{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.linqpad;
in {
  options.${namespace}.apps.linqpad = with types; {
    enable = mkEnableOption "Enable LINQPad";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (with dotnetCorePackages;
        combinePackages [
          sdk_9_0
          sdk_8_0
        ])
    ];
  };
}
