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
  cfg = config.${namespace}.tools.lsd;
in
{
  options.${namespace}.tools.lsd = with types; {
    enable = mkEnableOption "Whether or not to enable the lsd tool.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      lsd
    ];

    home.shellAliases = {
      ls = "${pkgs.lsd}/bin/lsd --group-dirs first";
      l = "ls --online --all";
      ll = "ls --long";
      la = "ls --all";
      lt = "ls --tree";
    };
  };
}
