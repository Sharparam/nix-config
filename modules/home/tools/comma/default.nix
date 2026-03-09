{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.comma;
in
{
  options.${namespace}.tools.comma = {
    enable = mkEnableOption "Whether or not to enable comma (and nix-index).";
  };

  config = mkIf cfg.enable {
    programs.nix-index.enable = true;
    programs.nix-index-database.comma.enable = true;
  };
}
