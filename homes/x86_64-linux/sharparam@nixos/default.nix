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
  environment.localBinInPath = true;
  ${namespace} = {
    tools = {
      home-manager = enabled;
      git = enabled;
      direnv = enabled;
      zsh = enabled;
    };
  };
}
