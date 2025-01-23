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
  sharparam = {
    tools = {
      home-manager = enabled;
      git = enabled;
      direnv = enabled;
      zsh = enabled;
    };
  };
}
