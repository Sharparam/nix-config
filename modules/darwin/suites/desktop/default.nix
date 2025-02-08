{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.suites.desktop;
in {
  options.${namespace}.suites.desktop = with types; {
    enable = mkEnableOption "Whether or not to enable common desktop configuration.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      security = {
        _1password = enabled;
        # TODO: bitwarden-cli doesn't build on nix-darwin
        # bitwarden = enabled;
      };

      apps = {
        firefox = enabled;
        slack = enabled;
        telegram = enabled;
      };
    };
  };
}
