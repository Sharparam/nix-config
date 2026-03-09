{
  lib,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.tools.ssh;
in
{
  options.${namespace}.tools.ssh = {
    enable = mkEnableOption "SSH";
    startAgent = mkOption {
      type = bool;
      default = false;
      description = "Start SSH agent";
    };
  };

  config = mkIf cfg.enable {
    programs.ssh = {
      inherit (cfg) startAgent;
    };
  };
}
