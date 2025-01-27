{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.curl;
in
{
  options.${namespace}.tools.curl = {
    enable = mkEnableOption "curl";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      curl
    ];
  };
}
