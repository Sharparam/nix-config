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
  cfg = config.${namespace}.security.age;
in
{
  options.${namespace}.security.age = with types; {
    enable = mkEnableOption "Enable (r)age";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      rage
    ];
  };
}
