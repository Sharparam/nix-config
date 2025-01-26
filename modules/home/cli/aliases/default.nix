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

  default-aliases = pkgs.writeText "default-alaises.shrc" (convertAliases {
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";
    status = "systemctl status";
    start = "sudo systemctl start";
    stop = "sudo systemctl stop";
    restart = "sudo systemctl restart";
    enable = "sudo systemctl enable";
    disable = "sudo systemctl disable";
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
