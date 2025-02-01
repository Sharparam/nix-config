{
  lib,
  pkgs,
  osConfig ? { },
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
{
  snix = {
    suites = {
      common = enabled;
    };

    tools.git.use1Password = true;
    tools.ssh = enabled;
  };
}
