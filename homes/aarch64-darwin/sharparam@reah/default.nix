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
        setAsDefault = true;
        fontSize = 14;
      };
      # vscode.fhs doesn't work on nix-darwin
      vscode = disabled;
    };

    tools = {
      azure = enabled;
      uv = enabled;
    };
  };

  home.stateVersion = "24.11";
}
