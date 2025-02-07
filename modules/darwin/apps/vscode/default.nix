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
    homebrew = {
      casks = [ "visual-studio-code" ];
    };
  };
}
