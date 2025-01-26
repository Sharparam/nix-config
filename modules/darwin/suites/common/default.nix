{
  lib,
  pkgs,
  namespace,
  options,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.suites.common;
in
{
  options.${namespace}.suites.common = with types; {
    enable = mkEnableOption "Whether or not to enable the common configuration.";
  };

  config = mkIf cfg.enable {
    programs.zsh = enabled;

    ${namespace} = {
      nix = enabled;
    };
  };
}
