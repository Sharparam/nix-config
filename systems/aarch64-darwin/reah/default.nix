{
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; {
  # TODO: Finish setup when laptop is actually received

  ${namespace} = {
    archetypes = {
      work = enabled;
    };

    security = {
      _1password.enableSshAgent = true;
    };

    desktop = {
      jankyborders = enabled;
      # yabai = enabled;
      # sketchybar = enabled;
    };
  };

  environment.systemPath = ["/opt/homebrew/bin"];

  system.stateVersion = 6;
}
