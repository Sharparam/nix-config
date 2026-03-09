{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.user;
  is-darwin = pkgs.stdenv.isDarwin;

  home-directory =
    if cfg.name == null then
      null
    else if is-darwin then
      "/Users/${cfg.name}"
    else
      "/home/${cfg.name}";
in
{
  options.${namespace}.user = {
    enable = mkEnableOption "Whether to configure the user account.";
    name = mkOption {
      type = types.nullOr types.str;
      default = config.snowfallorg.user.name or "sharparam";
      description = "The user account.";
    };
    uid = mkOption {
      type = types.int;
      default = 1000;
      description = "UID of the user.";
    };
    fullName = mkOption {
      type = types.str;
      default = "Adam Hellberg";
      description = "The full name of the user.";
    };
    email = mkOption {
      type = types.str;
      default = "sharparam@sharparam.com";
      description = "The email of the user.";
    };
    home = mkOption {
      type = types.nullOr types.str;
      default = home-directory;
      description = "The user's home directory.";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      assertions = [
        {
          assertion = cfg.name != null;
          message = "${namespace}.user.name must be set";
        }
        {
          assertion = cfg.home != null;
          message = "${namespace}.user.home must be set";
        }
      ];
      home = {
        username = mkDefault cfg.name;
        homeDirectory = mkDefault cfg.home;
      };
    }
  ]);
}
