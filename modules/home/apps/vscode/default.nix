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
  cfg = config.${namespace}.apps.vscode;
in
{
  options.${namespace}.apps.vscode = with types; {
    enable = mkEnableOption "Visual Studio Code";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      # enableUpdateCheck = true;
      # enableExtensionUpdateCheck = true;
      # mutableExtensionsDir = true;
      extensions = with pkgs.vscode-extensions; [

      ];
      userSettings = {

      };
    };
  };
}
