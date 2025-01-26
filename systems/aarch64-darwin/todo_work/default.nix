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
  };

  # environment.systemPath = [ "/opt/homebrew/bin" ];
}
