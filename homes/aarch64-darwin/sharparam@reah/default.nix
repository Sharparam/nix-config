{
  lib,
  pkgs,
  osConfig ? {},
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; {
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

    apps = {
      ghostty = {
        enable = true;
        setAsDefault = false;
        fontSize = 14;
      };
      obs = enabled;
      # vscode.fhs doesn't work on nix-darwin
      vscode = disabled;
    };

    tools = {
      azure = enabled;
    };
  };

  home.stateVersion = "24.11";
}
