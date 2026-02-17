{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.suites.development;
in {
  options.${namespace}.suites.development = with types; {
    enable = mkEnableOption "Development suite";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      apps = {
        emacs.enable = mkDefault true;
        vscode.enable = mkDefault true;
      };
      tools = {
        github.enable = mkDefault true;
        scc = enabled;
        tokei = enabled;
      };
    };
  };
}
