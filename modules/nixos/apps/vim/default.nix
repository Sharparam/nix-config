{
  lib,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.apps.vim;
in
{
  options.${namespace}.apps.vim = {
    enable = mkEnableOption "Vi IMproved";
  };

  config = mkIf cfg.enable {
    programs.vim = enabled;
  };
}
