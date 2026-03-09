{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.security.age;
in
{
  options.${namespace}.security.age = {
    enable = mkEnableOption "(r)age";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.rage
      pkgs.age-plugin-yubikey
    ];
  };
}
