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
    user = {
      enable = true;
      name = config.snowfallorg.user.name;
      email = "adam.hellberg@ninetech.com";
    };

    suites = {
      common = enabled;
      desktop = enabled;
    };
  };
}
