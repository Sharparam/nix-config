{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.${namespace}.apps.etcher;
in
{
  options.${namespace}.apps.etcher = {
    enable = lib.mkEnableOption "etcher";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "balenaetcher" ];
  };
}
