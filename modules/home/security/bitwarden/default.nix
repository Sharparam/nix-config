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
  cfg = config.${namespace}.security.bitwarden;
in
{
  options.${namespace}.security.bitwarden = with types; {
    enable = mkEnableOption "Enable Bitwarden";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      bitwarden-desktop
      bitwarden-cli
    ];
  };
}
