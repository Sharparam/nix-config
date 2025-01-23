{
  lib,
  pkgs,
  namespace,
  options,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.archetypes.workstation;
in
{
  options.${namespace}.archetypes.workstation = with types; {
    enable = mkEnableOption "Whether or not to enable the workstation archetype.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      suites = {
        common = enabled;
        desktop = enabled;
        development = enabled;
      };
    };
  };
}
