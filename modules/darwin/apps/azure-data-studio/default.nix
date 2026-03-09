{
  lib,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.apps.azure-data-studio;
in
{
  options.${namespace}.apps.azure-data-studio = with types; {
    enable = mkEnableOption "Azure Data Studio";
  };

  config = mkIf cfg.enable {
    homebrew = {
      casks = [ "azure-data-studio" ];
    };
  };
}
