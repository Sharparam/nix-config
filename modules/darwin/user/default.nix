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
in
{
  options.${namespace}.user = with types; {
    name = mkOpt str "sharparam" "The user account.";
    fullName = mkOpt str "Adam Hellberg" "The full name of the user.";
    email = mkOpt str "sharparam@sharparam.com" "The email of the user.";
    uid = mkOpt (nullOr int) 501 "The UID for the user account.";
  };

  config = {
    users.user.${cfg.name} = {
      uid = mkIf (cfg.uid != null) cfg.uid;
    };
  };
}
