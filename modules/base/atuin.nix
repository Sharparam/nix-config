let
  logLevel = "warn";
in
{
  den.aspects.base = {
    homeManager =
      { config, lib, ... }:
      {
        programs.atuin = {
          enable = true;
          enableZshIntegration = true;
          # Daemon support is only in unstable
          daemon = {
            enable = true;
            logLevel = logLevel;
          };
          settings = {
            auto_sync = true;
            dialect = "uk";
            enter_accept = true;
            filter_mode = "global";
            filter_mode_shell_up_key_binding = "session";
            keymap_mode = "auto";
            search_mode = "daemon-fuzzy";
            sync_address = "https://atuin.sharparam.com";
            logs = {
              level = logLevel;
            };
            sync = {
              records = true;
            };
          };
        };
        programs.claude-code.settings =
          let
            atuin = lib.getExe config.programs.atuin.package;
          in
          {
            hooks = {
              PostToolUse = [
                {
                  hooks = [
                    {
                      command = "${atuin} hook claude-code";
                      type = "command";
                    }
                  ];
                  matcher = "Bash";
                }
              ];
              PostToolUseFailure = [
                {
                  hooks = [
                    {
                      command = "${atuin} hook claude-code";
                      type = "command";
                    }
                  ];
                  matcher = "Bash";
                }
              ];
              PreToolUse = [
                {
                  hooks = [
                    {
                      command = "${atuin} hook claude-code";
                      type = "command";
                    }
                  ];
                  matcher = "Bash";
                }
              ];
            };
          };
      };
  };
}
