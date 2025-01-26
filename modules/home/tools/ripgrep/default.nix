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
  cfg = config.${namespace}.tools.ripgrep;
in
{
  options.${namespace}.tools.ripgrep = with types; {
    enable = mkEnableOption "Whether or not to enable the ripgrep tool.";
  };

  config = mkIf cfg.enable {
    programs.ripgrep = enabled;
  };
}
