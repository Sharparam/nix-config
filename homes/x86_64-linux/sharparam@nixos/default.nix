{
  lib,
  pkgs,
  osConfig ? {},
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; {
  snix = {
    suites = {
      common = enabled;
    };

    tools.ssh = enabled;

    apps = {
      ghostty = enabled;
    };
  };

  home.stateVersion = "24.11";
}
