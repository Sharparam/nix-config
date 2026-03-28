{
  den.default = {
    homeManager = {
      home.shellAliases = {
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";
        "......" = "cd ../../../../..";
        "......." = "cd ../../../../../..";

        status = "systemctl status";
        start = "sudo systemctl start";
        stop = "sudo systemctl stop";
        restart = "sudo systemctl restart";
        reload = "sudo systemctl reload";
        enable = "sudo systemctl enable";
        disable = "sudo systemctl disable";

        ":q" = "exit";
        ":q!" = "exit";
        ":wq" = "exit";
        ":x" = "exit";
      };

      programs.bash = {
        initExtra = ''
          launch() {
            nohup $@ &>/dev/null & disown
          }

          take() {
            mkdir -p "$1" && cd "$1"
          }
        '';
      };

      programs.zsh = {
        shellAliases = {
          "-" = "cd -";
        };

        siteFunctions = {
          launch = "nohup $@ &>/dev/null & disown";
          take = ''mkdir -p "$1" && cd "$1"'';
        };
      };
    };
  };
}
