{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.${namespace}.apps.azure-data-studio;
in
{
  options.${namespace}.apps.azure-data-studio = {
    enable = lib.mkEnableOption "Azure Data Studio";
  };

  config = mkIf cfg.enable {
    homebrew = {
      casks = [ "azure-data-studio" ];
    };
  };
}
