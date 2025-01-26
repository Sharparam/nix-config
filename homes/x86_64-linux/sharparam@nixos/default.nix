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
