{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.apps.vscode;
in
{
  options.${namespace}.apps.vscode = {
    enable = mkEnableOption "Visual Studio Code";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
      # enableUpdateCheck = true;
      # enableExtensionUpdateCheck = true;
      # mutableExtensionsDir = true;
      # extensions = builtins.attrValues { inherit (pkgs.vscode-extensions)
      #   ;
      # };
      # userSettings = {
      #
      # };
    };
  };
}
