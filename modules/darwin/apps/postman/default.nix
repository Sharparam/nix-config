{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.apps.postman;
in
{
  options.${namespace}.apps.postman = {
    enable = mkEnableOption "Postman";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "postman" ];
  };
}
