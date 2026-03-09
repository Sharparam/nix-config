{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.suites.desktop;
in
{
  options.${namespace}.suites.desktop = {
    enable = mkEnableOption "Whether or not to enable common desktop configuration.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      security = {
        _1password.enable = true;
        # TODO: bitwarden-cli doesn't build on nix-darwin
        # bitwarden.enable = true;
      };

      desktop = {
        skhd.enable = true;
      };

      apps = {
        dropbox.enable = true;
        ghostty.enable = true;
        google = {
          chrome.enable = true;
          drive.enable = true;
        };
        firefox.enable = true;
        kde-connect.enable = true;
        signal.enable = true;
        slack.enable = true;
        spotify.enable = true;
        telegram.enable = true;
      };
    };
  };
}
