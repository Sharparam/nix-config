{
  lib,
  pkgs,
  osConfig ? { },
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
{
  snix = {
    user = {
      enable = true;
      name = config.snowfallorg.user.name;
      email = "adam.hellberg@ninetech.com";
    };

    suites = {
      common = enabled;
      desktop = enabled;
      development = enabled;
    };

    # vscode.fhs doesn't work on nix-darwin
    apps.vscode = disabled;

    tools = {
      azure = enabled;
    };
  };

  home.stateVersion = "24.11";
}
