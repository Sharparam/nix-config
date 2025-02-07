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
  cfg = config.${namespace}.suites.development;
in
{
  options.${namespace}.suites.development = with types; {
    enable = mkEnableOption "Development suite";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      apps = {
        vscode.enable = mkDefault true;
      };
    };
  };
}
