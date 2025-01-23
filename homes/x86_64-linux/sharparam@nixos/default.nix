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
      git = enabled;
      direnv = enabled;
      zsh = enabled;
    };
  };
}
