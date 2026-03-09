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
  options.${namespace}.tools.atuin = with types; {
    enable = mkEnableOption "Atuin";
    enableDaemon = mkOption {
      type = bool;
      default = true;
      description = "Whether or not to run the Atuin daemon.";
    };
    enableSync = mkOption {
      type = bool;
      default = true;
      description = "Whether to enable syncing";
    };
    enableZvmWorkaround = mkOption {
      type = bool;
      default = false;
      description = "Apply zsh-vi-mode workaround.";
    };
    syncAddress = mkOption {
      type = str;
      default = "https://atuin.sharparam.com";
      description = "Sync address to use.";
    };
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
        auto_sync = cfg.enableSync;
        dialect = "uk";
        enter_accept = true;
        filter_mode = "global";
        filter_mode_shell_up_key_binding = "session";
        keymap_mode = "auto";
        sync_address = cfg.syncAddress;
        sync = {
          records = true;
        };
      };
    };

    programs.zsh.initContent =
      let
        flagsStr = escapeShellArgs config.programs.atuin.flags;
      in
      mkIf cfg.enableZvmWorkaround (mkAfter ''
        if [[ $options[zle] = on ]]; then
          function atuin_init() {
            eval "$(${pkgs.atuin}/bin/atuin init zsh ${flagsStr})"
          }
          zvm_after_init_commands+=(atuin_init)
        fi
      '');
  };
}
