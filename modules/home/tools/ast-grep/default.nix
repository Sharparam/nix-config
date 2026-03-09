{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.ast-grep;
in
{
  options.${namespace}.tools.ast-grep = {
    enable = mkEnableOption "Whether or not to enable the ast-grep tool.";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.ast-grep
    ];

    home.shellAliases = {
      sg = "ast-grep";
    };
  };
}
