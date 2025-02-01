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
  cfg = config.${namespace}.suites.desktop;
in
{
  options = {
    enable = mkEnabledOption "Enable Desktop suite.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      apps = {
        discord = enabled;
      };
    };
  };
}
