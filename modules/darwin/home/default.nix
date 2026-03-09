{
  lib,
  namespace,
  options,
  config,
  ...
}:
let
  inherit (lib)
    mkAliasDefinitions
    mkOption
    types
    ;
in
{
  options.${namespace}.home =
    let
      inherit (types) attrs;
    in
    {
      file = mkOption {
        type = attrs;
        default = { };
        description = "A set of files to be managed by home-manager's `home.file`.";
      };
      configFile = mkOption {
        type = attrs;
        default = { };
        description = "A set of files to be managed by home-manager's `xdg.configFile`.";
      };
      extraOptions = mkOption {
        type = attrs;
        default = { };
        description = "Options to pass directly to home-manager.";
      };
      homeConfig = mkOption {
        type = attrs;
        default = { };
        description = "Final config for home-manager.";
      };
    };

  config = {
    ${namespace}.home.extraOptions = {
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
