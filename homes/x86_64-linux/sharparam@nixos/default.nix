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
  snix = {
    tools = {
      home-manager = enabled;
      comma = enabled;
      direnv = enabled;
      git = enabled;
      gpg = enabled;
      htop = enabled;
      hyfetch = enabled;
      kitty = enabled;
      zsh = enabled;
      ssh = enabled;
    };
  };
}
