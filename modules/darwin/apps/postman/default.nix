{
  lib,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
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
