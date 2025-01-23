{
  lib,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.tools.comma;
in
{
  options.${namespace}.tools.comma = {
    enable = mkEnableOption "Whether or not to enable comma (and nix-index).";
  };

  config = mkIf cfg.enable {
    programs.nix-index = enabled;
    programs.nix-index-database.comma.enable = true;
  };
}
