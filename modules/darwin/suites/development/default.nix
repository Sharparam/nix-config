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
  cfg = config.${namespace}.suites.development;
in
{
  options.${namespace}.suites.development = with types; {
    enable = mkEnableOption "Whether or not to enable the development suite.";
  };

  config = mkIf cfg.enable {
    homebrew = {
      masApps = mkIf config.${namespace}.tools.homebrew.enableMas {
        # "Xcode" = 497799835;
      };
    };

    ${namespace} = {
      apps = {
        azure-data-studio = enabled;
        jetbrains.toolbox = enabled;
        sublime-merge = enabled;
        vscode = enabled;
      };
    };
  };
}
