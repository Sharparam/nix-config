{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;
  cfg = config.${namespace}.tools.bat;
in
{
  options.${namespace}.tools.bat = {
    enable = mkEnableOption "Whether or not to enable the bat tool.";
  };

  config = mkIf cfg.enable {
    programs.bat.enable = true;

    home.shellAliases = {
      cat = "bat --paging=never";
    };
  };
}
