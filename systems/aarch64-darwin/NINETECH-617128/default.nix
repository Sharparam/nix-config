{
  namespace,
  ...
}:
{
  ${namespace} = {
    archetypes = {
      work.enable = true;
    };

    security = {
      _1password.enableSshAgent = true;
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
