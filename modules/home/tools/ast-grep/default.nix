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
  cfg = config.${namespace}.tools.ast-grep;
in
{
  options.${namespace}.tools.ast-grep = with types; {
    enable = mkEnableOption "Whether or not to enable the ast-grep tool.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ast-grep
    ];

    ${namespace}.cli.aliases = {
      sg = "${pkgs.ast-grep}/bin/ast-grep";
    };
  };
}
