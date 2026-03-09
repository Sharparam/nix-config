{
  namespace,
  ...
}:
{
  # TODO: Finish setup when laptop is actually received

  ${namespace} = {
    archetypes = {
      work.enable = true;
    };

    security = {
      _1password.enableSshAgent = true;
    };

    desktop = {
      # jankyborders.enable = true;
      # yabai.enable = true;
      # sketchybar.enable = true;
    };

    apps = {
      etcher.enable = true;
      # linqpad.enable = true;
      obs.enable = true;
      sweet-home3d.enable = true;
    };
  };

  environment.systemPath = [ "/opt/homebrew/bin" ];

  system.stateVersion = 6;
}
