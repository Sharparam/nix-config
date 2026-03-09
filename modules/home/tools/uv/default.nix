{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.uv;
in
{
  options.${namespace}.tools.uv = {
    enable = mkEnableOption "uv";
  };

  config = mkIf cfg.enable {
    programs.uv = {
      enable = true;
    };
  };
}
