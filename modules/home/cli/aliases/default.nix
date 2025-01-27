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

  default-aliases = pkgs.writeText "default-aliases.shrc" (convertAliases {
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";
    "......" = "cd ../../../../..";
    "......." = "cd ../../../../../..";
    "-" = "cd -";
    ll = "ls --long";
    la = "ls --all";

    launch = "nohup $@ &>/dev/null & disown";

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
  });
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
    programs.zsh.initExtra = lib.mkAfter ''
      source ${default-aliases}
      source ${aliasesFile}
    '';
  };
}
