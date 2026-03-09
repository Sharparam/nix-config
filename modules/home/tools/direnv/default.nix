{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.direnv;
in
{
  options.${namespace}.tools.direnv = {
    enable = mkEnableOption "Whether or not to enable direnv.";
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
