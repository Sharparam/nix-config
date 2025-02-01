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
    homebrew = {
      taps = [ "1password/tap" ];
      casks = [ "1password" ];

      masApps = mkIf config.${namespace}.tools.homebrew.enableMas {
        "1Password for Safari" = 1569813296;
      };
    };

    programs.ssh = mkIf cfg.enableSshAgent {
      extraConfig = ''
        Host *
          IdentityAgent ~/.1password/agent.sock
      '';
    };
  };
}
