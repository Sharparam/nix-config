{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.archetypes.work;
in
{
  options.${namespace}.archetypes.work = {
    enable = mkEnableOption "Whether or not to enable the work archetype.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      suites = {
        common.enable = true;
        desktop.enable = true;
        development.enable = true;
      };

      tools = {
        podman.enable = true;
      };

      apps = {
        postman.enable = true;
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
