{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkDefault mkEnableOption mkIf;
  cfg = config.${namespace}.suites.development;
in
{
  options.${namespace}.suites.development = {
    enable = mkEnableOption "Development suite";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      apps = {
        emacs.enable = mkDefault true;
        vscode.enable = mkDefault true;
      };
      tools = {
        ast-grep.enable = true;
        codespelunker.enable = true;
        github.enable = mkDefault true;
        scc.enable = true;
        tokei.enable = true;
      };
    };
  };
}
