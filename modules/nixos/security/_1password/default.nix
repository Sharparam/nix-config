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
  options.${namespace}.security._1password = with types; {
    enable = mkEnableOption "Enable 1Password";
    enableSshAgent = mkBoolOpt false "Enable SSH agent integration";
  };

  config = mkIf cfg.enable {
    programs = {
      _1password = enabled;
      _1password-gui = {
        enable = true;
        polkitPolicyOwners = [ config.${namespace}.user.name ];
      };

      ssh = mkIf cfg.enableSshAgent {
        extraConfig = ''
          Host *
            IdentityAgent ~/.1password/agent.sock
        '';
      };
    };
  };
}
