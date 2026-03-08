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
  cfg = config.${namespace}.tools.bat;
in
{
  options.${namespace}.tools.bat = with types; {
    enable = mkEnableOption "Whether or not to enable the bat tool.";
  };

  config = mkIf cfg.enable {
    programs.bat = enabled;

    home.shellAliases = {
      cat = "${pkgs.bat}/bin/bat --paging=never";
    };
  };
}
