{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.snix.tools.bash;
in
{
  options.snix.tools.bash = {
    enable = lib.mkEnableOption "bash";
    package = lib.mkPackageOption pkgs "bash" {
      nullable = true;
      default = "bashInteractive";
    };
  };

  config = mkIf cfg.enable {
    programs.bash = {
      enable = true;
      inherit (cfg) package;
      enableVteIntegration = true;
    };
  };
}
