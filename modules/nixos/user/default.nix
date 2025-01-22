{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.sharparam.user;
  uid = cfg.uid;
  username = cfg.username;
  description = cfg.description;
  extraGroups = cfg.extraGroups;
in
{
  options.sharparam.user = {
    enable = lib.mkEnableOption "Enables the sharparam user.";
    uid = lib.mkOption {
      type = lib.types.nullOr lib.types.int;
      default = 1000;
      description = "UID for this system.";
    };
    username = lib.mkOption {
      type = lib.types.str;
      default = "sharparam";
      description = "Username for this system.";
    };
    description = lib.mkOption {
      type = lib.types.str;
      default = "Adam Hellberg";
      description = "Description for the user.";
    };
    extraGroups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Extra groups for the user.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.localBinInPath = true;
    programs.zsh.enable = true;

    users.users.${username} = {
      isNormalUser = true;
      uid = uid;
      description = description;
      extraGroups = [ "wheel" ] ++ extraGroups;
      shell = pkgs.zsh;
    };
  };
}
