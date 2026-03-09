{
  lib,
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
    homebrew = {
      casks = [ "visual-studio-code" ];
    };
  };
}
