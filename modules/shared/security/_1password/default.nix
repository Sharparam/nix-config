{
  lib,
  pkgs,
  inputs,
  namespace,
  system,
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
    ${namespace}.home.extraOptions =
      {
        programs.zsh.initExtra = ''
          [ -f "$HOME/.config/op/plugins.sh" ] && source "$HOME/.config/op/plugins.sh"
        '';

        xdg.configFile."direnv/lib/oprc.sh".source =
          optionalString config.${namespace}.tools.direnv.enable
            "${pkgs.snix.direnv-op}/share/direnv-op/oprc.sh";
      }
      // mkIf cfg.enableSshAgent {
        ${namespace}.tools.git.use1Password = true;
        programs.ssh = {
          includes = [ "~/.ssh/1Password/config" ];
          extraOptionOverrides = {
            IdentityAgent = "~/.1password/agent.sock";
          };
        };
        programs.zsh = {
          sessionVariables = {
            SSH_AUTH_SOCK = "$HOME/.1password/agent.sock";
          };
        };
      };
  };
}
