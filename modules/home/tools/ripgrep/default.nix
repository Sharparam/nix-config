{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.ripgrep;
in
{
  options.${namespace}.tools.ripgrep = {
    enable = mkEnableOption "Whether or not to enable the ripgrep tool.";
  };

  config = mkIf cfg.enable {
    programs.ripgrep.enable = true;
  };
}
