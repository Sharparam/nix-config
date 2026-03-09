{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.snix.tools.nh;
in
{
  options.snix.tools.nh = {
    enable = mkEnableOption "nh";
  };

  config = mkIf cfg.enable {
    programs.nh = {
      enable = true;
      flake = "${config.home.homeDirectory}/repos/github.com/Sharparam/nix-config";
    };
  };
}
