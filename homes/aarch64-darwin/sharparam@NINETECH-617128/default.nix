{
  config,
  ...
}:
{
  snix = {
    user = {
      enable = true;
      inherit (config.snowfallorg.user) name;
      email = "adam.hellberg@ninetech.com";
    };

    suites = {
      common.enable = true;
      desktop.enable = true;
      development.enable = true;
    };

    apps = {
      ghostty = {
        enable = true;
        setAsDefault = true;
        fontSize = 14;
      };
      # vscode.fhs doesn't work on nix-darwin
      vscode.enable = false;
    };

    tools = {
      azure.enable = true;
      uv.enable = true;
    };
  };

  home.stateVersion = "24.11";
}
