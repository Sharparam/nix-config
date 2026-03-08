{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.snix.tools.nushell;
in
{
  options.snix.tools.nushell = {
    enable = lib.mkEnableOption "nushell";
    package = lib.mkPackageOption pkgs "nushell" {
      nullable = true;
    };
  };

  config = mkIf cfg.enable {
    programs.nushell = {
      enable = true;
      package = cfg.package;
    };
  };
}
