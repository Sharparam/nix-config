{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.suites.development;
in
{
  options.${namespace}.suites.development = {
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
        atuin-desktop.enable = true;
        azure-data-studio.enable = true;
        emacs.enable = true;
        jetbrains.toolbox.enable = true;
        sublime-merge.enable = true;
        vscode.enable = true;
      };
    };
  };
}
