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
  cfg = config.${namespace}.security._1password;
in
{
  imports = [ (lib.snowfall.fs.get-file "modules/shared/security/_1password/default.nix") ];

  config = mkIf cfg.enable {
    programs = {
      _1password = enabled;
      _1password-gui = {
        enable = true;
        polkitPolicyOwners = [ config.${namespace}.user.name ];
      };
    };
  };
}
