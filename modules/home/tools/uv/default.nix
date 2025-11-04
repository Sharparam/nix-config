{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.uv;
in {
  options.${namespace}.tools.uv = {
    enable = mkEnableOption "uv";
  };

  config = mkIf cfg.enable {
    programs.uv = {
      enable = true;
    };
  };
}
