{
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
{
  # TODO: Finish setup when laptop is actually received

  ${namespace} = {
    archetypes = {
      work = enabled;
    };

    security = {
      _1password.enableSshAgent = true;
    };
  };

  # environment.systemPath = [ "/opt/homebrew/bin" ];
}
