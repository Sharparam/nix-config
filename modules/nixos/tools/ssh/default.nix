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
    startAgent = mkBoolOpt false "Start SSH agent";
  };

  config = mkIf cfg.enable {
    programs.ssh = {
      startAgent = cfg.startAgent;
    };
  };
}
