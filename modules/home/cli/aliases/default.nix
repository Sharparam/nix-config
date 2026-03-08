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
  aliasesFile = pkgs.writeText "aliases.shrc" "${convertAliases config.${namespace}.cli.aliases}";
in
{
  options.${namespace}.cli.aliases =
    with types;
    mkOption {
      type = attrsOf str;
      default = { };
      description = "A set of aliases to add to the user's shell.";
    };

  config = {
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
          mkdir --parents "$1" && cd "$1"
        }
      '';
    };

    programs.zsh = {
      shellAliases = {
        "-" = "cd -";
      };

      siteFunctions = {
        launch = "nohup $@ &>/dev/null & disown";
        take = ''mkdir --parents "$1" && cd "$1"'';
      };

      initContent = lib.mkBefore ''
        source ${aliasesFile}
      '';
    };
  };
}
