{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.tools.azure;
in
{
  options.${namespace}.tools.azure = with types; {
    enable = mkEnableOption "Whether or not to enable Azure CLI tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      azure-cli
      azure-cli-extensions.account
      azure-storage-azcopy
    ];
  };
}
