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

    security = {
      bitwarden = enabled;
    };

    tools.ssh = enabled;
  };
}
