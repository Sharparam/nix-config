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

    ${namespace}.cli.aliases = {
      ls = "${pkgs.lsd}/bin/lsd --group-dirs first $@";
      la = "${pkgs.lsd}/bin/lsd --long --all --group-dirs first $@";
    };
  };
}
