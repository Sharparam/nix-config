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

    ${namespace}.home.extraOptions = mkIf cfg.enableSshAgent {
      ${namespace}.tools.git.use1Password = true;
      programs.ssh.extraOptionOverrides = {
        IdentityAgent = "~/.1password/agent.sock";
      };
      programs.zsh.sessionVariables = {
        SSH_AUTH_SOCK = "$HOME/.1password/agent.sock";
      };
    };
  };
}
