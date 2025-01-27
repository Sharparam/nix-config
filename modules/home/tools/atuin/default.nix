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
  cfg = config.${namespace}.tools.atuin;
in
{
  options.${namespace}.tools.atuin = {
    enable = mkEnableOption "Atuin";
    enableDaemon = mkBoolOpt true "Whether or not to run the Atuin daemon.";
  };

  config = mkIf cfg.enable {
    programs.atuin = {
      enable = true;
      # TODO: Daemon support is only in unstable
      # daemon = {
      #   enable = cfg.enableDaemon;
      #   logLevel = "warn";
      # };
      settings = {
        dialect = "uk";
        enter_accept = true;
        sync = {
          records = true;
        };
      };
    };
  };
}
