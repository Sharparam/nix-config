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
      hyfetch = enabled;
      zsh = enabled;
    };
  };
}
