{
  lib,
  namespace,
  options,
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
    file = mkOpt attrs { } "A set of files to be managed by home-manager's `home.file`.";
    configFile = mkOpt attrs { } "A set of files to be managed by home-manager's `xdg.configFile`.";
    extraOptions = mkOpt attrs { } "Options to pass directly to home-manager.";
  };

  config = {
    ${namespace}.home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.${namespace}.home.file;
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.${namespace}.home.configFile;
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      # backupFileExtension = "backup";

      users.${config.${namespace}.user.name} = mkAliasDefinitions options.${namespace}.home.extraOptions;
    };
  };
}
