{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.archetypes.workstation;
in
{
  options.${namespace}.archetypes.workstation = {
    enable = mkEnableOption "Whether or not to enable the workstation archetype.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      suites = {
        common.enable = true;
        desktop.enable = true;
        development.enable = true;
      };
    };
  };
}
