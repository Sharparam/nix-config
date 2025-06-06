{
  lib,
  pkgs,
  namespace,
  options,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.archetypes.work;
in {
  options.${namespace}.archetypes.work = with types; {
    enable = mkEnableOption "Whether or not to enable the work archetype.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      suites = {
        common = enabled;
        desktop = enabled;
        development = enabled;
      };

      tools = {
        podman = enabled;
      };

      apps = {
        postman = enabled;
      };
    };

    homebrew = {
      casks = [
        "microsoft-auto-update"
        "microsoft-teams"
      ];
      masApps = mkIf config.${namespace}.tools.homebrew.enable {
        "Microsoft Outlook" = 985367838;
      };
    };
  };
}
