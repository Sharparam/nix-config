{
  lib,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.apps.etcher;
in
{
  options.${namespace}.apps.etcher = with types; {
    enable = mkEnableOption "etcher";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "balenaetcher" ];
  };
}
