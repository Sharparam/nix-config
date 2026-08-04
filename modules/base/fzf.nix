{
  den.aspects.base = {
    homeManager = {
      programs.fzf =
        let
          fd = "fd";
        in
        {
          enable = true;
          defaultCommand = "${fd} --type f --hidden --exclude \".git\"";
          changeDirWidget.command = "${fd} --type d --hidden --exclude \".git\"";
          fileWidget.command = "${fd} --type f --hidden --exclude \".git\"";
          historyWidget.command = ""; # We use atuin instead
          tmux.enableShellIntegration = true;
        };
    };
  };
}
