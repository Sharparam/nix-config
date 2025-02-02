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
  cfg = config.${namespace}.tools.atuin;
in
{
  options.${namespace}.tools.atuin = {
    enable = mkEnableOption "Atuin";
    enableDaemon = mkBoolOpt true "Whether or not to run the Atuin daemon.";
    enableZvmWorkaround = mkBoolOpt false "Apply zsh-vi-mode workaround.";
  };

  config = mkIf cfg.enable {
    programs.atuin = {
      enable = true;
      enableZshIntegration = !cfg.enableZvmWorkaround;
      # Daemon support is only in unstable
      daemon = {
        enable = cfg.enableDaemon;
        logLevel = "warn";
      };
      settings = {
        dialect = "uk";
        enter_accept = true;
        sync = {
          records = true;
        };
      };
    };

    programs.zsh.initExtra =
      let
        flagsStr = escapeShellArgs config.programs.atuin.flags;
      in
      mkIf cfg.enableZvmWorkaround ''
        if [[ $options[zle] = on ]]; then
          function atuin_init() {
            eval "$(${pkgs.atuin}/bin/atuin init zsh ${flagsStr})"
          }
          zvm_after_init_commands+=(atuin_init)
        fi
      '';
  };
}
