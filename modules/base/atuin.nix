{
  den.aspects.base = {
    homeManager = {
      programs.atuin = {
        enable = true;
        enableZshIntegration = true;
        # Daemon support is only in unstable
        daemon = {
          enable = true;
          logLevel = "warn";
        };
        settings = {
          auto_sync = true;
          dialect = "uk";
          enter_accept = true;
          filter_mode = "global";
          filter_mode_shell_up_key_binding = "session";
          keymap_mode = "auto";
          sync_address = "https://atuin.sharparam.com";
          sync = {
            records = true;
          };
        };
      };
    };
  };
}
