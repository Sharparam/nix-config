{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.apps.vim;
in
{
  options.${namespace}.apps.vim = {
    enable = mkEnableOption "Vi IMproved";
  };

  config = mkIf cfg.enable {
    programs.vim.enable = true;
  };
}
