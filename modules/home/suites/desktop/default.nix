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
  cfg = config.${namespace}.suites.desktop;
in
{
  options.${namespace}.suites.desktop = {
    enable = mkEnableOption "Enable Desktop suite.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      apps = {
        discord = enabled;
        ghostty = enabled;
        # TODO: Firefox is broken on darwin
        # https://github.com/NixOS/nixpkgs/issues/366581
        # See firefox module in the darwin tree instead
        # firefox = enabled;
      };
    };
  };
}
