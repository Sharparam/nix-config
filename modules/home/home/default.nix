{
  lib,
  osConfig ? { },
  namespace,
  ...
}:
with lib;
{
  home.stateVersion = mkDefault (osConfig.system.stateVersion or "24.11");
}
