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

      desktop = {
        # skhd = enabled;
      };

      apps = {
        dropbox = enabled;
        ghostty = enabled;
        google = {
          chrome = enabled;
          drive = enabled;
        };
        firefox = enabled;
        kde-connect = enabled;
        slack = enabled;
        spotify = enabled;
        telegram = enabled;
      };
    };
  };
}
