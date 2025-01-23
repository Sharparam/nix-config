{
  lib,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.home;
in
{
  options.${namespace}.home = with types; {
    extraOptions = mkOpt attrs { } "Options to pass directly to home-manager.";
  };

  config = {
    ${namespace}.home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      xdg.enable = true;
    };
    snowfallorg.users.${config.${namespace}.user.name}.home.config = cfg.extraOptions;
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
    };
  };
}
