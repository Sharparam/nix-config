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
      # Shouldn't need the tap since 1Password seems to be in default offerings now?
      # taps = [ "1password/tap" ];
      casks = [
        "1password"
        "1password-cli"
      ];

      masApps = mkIf config.${namespace}.tools.homebrew.enableMas {
        "1Password for Safari" = 1569813296;
      };
    };

    ${namespace}.home.extraOptions = mkIf cfg.enableSshAgent {
      ${namespace}.tools.git.use1Password = true;
      programs.ssh.extraOptionOverrides = {
        IdentityAgent = "~/.1password/agent.sock";
      };
      programs.zsh = {
        sessionVariables = {
          SSH_AUTH_SOCK = "$HOME/.1password/agent.sock";
        };
        initExtra = ''
          [ -f "$HOME/.config/op/plugins.sh" ] && source "$HOME/.config/op/plugins.sh"
        '';
      };
    };
  };
}
