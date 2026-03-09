{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.azure;
in
{
  options.${namespace}.tools.azure = {
    enable = mkEnableOption "Whether or not to enable Azure CLI tools.";
  };

  config = mkIf cfg.enable {
    home.packages = builtins.attrValues {
      inherit (pkgs)
        azure-cli
        azure-storage-azcopy
        ;

      inherit (pkgs.azure-cli-extensions)
        account
        ;
    };
  };
}
