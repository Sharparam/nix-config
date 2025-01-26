{
  lib,
  pkgs,
  osConfig,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
{
  catppuccin = {
    enable = true;
    flavor = "frappe";
  };

  snix = {
    user = {
      enable = true;
      name = config.snowfallorg.user.name;
      email = "adam.hellberg@ninetech.com";
    };

    security = {
      gpg = enabled;
    };

    apps = {
      kitty = enabled;
    };

    tools = {
      home-manager = enabled;
      comma = enabled;
      direnv = enabled;
      git = enabled;
      htop = enabled;
      hyfetch = enabled;
      zsh = enabled;
      ssh = enabled;
    };
  };
}
