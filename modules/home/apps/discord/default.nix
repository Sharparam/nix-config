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
  cfg = options.${namespace}.apps.discord;
in
{
  options = {
    enable = mkEnabledOption "Enable Discord.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      vesktop
    ];
  };
}
