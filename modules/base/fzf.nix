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
          changeDirWidgetCommand = "${fd} --type d --hidden --exclude \".git\"";
          fileWidgetCommand = "${fd} --type f --hidden --exclude \".git\"";
          tmux.enableShellIntegration = true;
        };
    };
  };
}
