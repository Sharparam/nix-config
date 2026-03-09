{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.security._1password;
in
{
  options.${namespace}.security._1password = {
    enable = mkEnableOption "1Password";
    enableSshAgent = mkEnableOption "SSH agent integration";
  };

  config = mkIf cfg.enable {
    ${namespace}.home.extraOptions = {
      programs = {
        zsh = {
          initContent = lib.mkAfter ''
            [ -f "$HOME/.config/op/plugins.sh" ] && source "$HOME/.config/op/plugins.sh"
          '';

          sessionVariables = mkIf cfg.enableSshAgent {
            SSH_AUTH_SOCK = "$HOME/.1password/agent.sock";
          };
        };

        ssh = mkIf cfg.enableSshAgent {
          includes = [ "~/.ssh/1Password/config" ];
          extraOptionOverrides = {
            IdentityAgent = "~/.1password/agent.sock";
          };
        };
      };

      xdg.configFile."direnv/lib/oprc.sh".source = "${pkgs.snix.direnv-op}/share/direnv-op/oprc.sh";

      ${namespace}.tools.git.use1Password = cfg.enableSshAgent;
    };
  };
}
