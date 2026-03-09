{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  cfg = config.${namespace}.tools.ssh;
in
{
  options.${namespace}.tools.ssh = {
    enable = mkEnableOption "SSH";
    startAgent = mkOption {
      type = types.bool;
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
