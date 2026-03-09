{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkIf mkOption types;
  cfg = config.${namespace}.user;
in
{
  options.${namespace}.user =
    let
      inherit (types) int nullOr str;
    in
    {
      name = mkOption {
        type = str;
        default = "sharparam";
        description = "The user account.";
      };
      fullName = mkOption {
        type = str;
        default = "Adam Hellberg";
        description = "The full name of the user.";
      };
      email = mkOption {
        type = str;
        default = "sharparam@sharparam.com";
        description = "The email of the user.";
      };
      uid = mkOption {
        type = nullOr int;
        default = 501;
        description = "The UID for the user account.";
      };
    };

  config = {
    users.users.${cfg.name} = {
      uid = mkIf (cfg.uid != null) cfg.uid;
      shell = pkgs.zsh;
    };

    system.primaryUser = cfg.name;
  };
}
