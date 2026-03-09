{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.security.bitwarden;
in
{
  options.${namespace}.security.bitwarden = {
    enable = mkEnableOption "Bitwarden";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.bitwarden-cli
    ];

    homebrew.casks = [ "bitwarden" ];
  };
}
