{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.suites.development;
in {
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
        atuin-desktop = enabled;
        azure-data-studio = enabled;
        emacs = enabled;
        jetbrains.toolbox = enabled;
        sublime-merge = enabled;
        vscode = enabled;
      };
    };
  };
}
