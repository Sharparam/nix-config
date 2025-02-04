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
  cfg = config.${namespace}.security._1password;
in
{
  imports = [ (lib.snowfall.fs.get-file "modules/shared/security/_1password/default.nix") ];

  config = mkIf cfg.enable {
    homebrew = {
      # Shouldn't need the tap since 1Password seems to be in default offerings now?
      # taps = [ "1password/tap" ];
      casks = [
        "1password"
        "1password-cli"
      ];

      masApps = mkIf config.${namespace}.tools.homebrew.enableMas {
        "1Password for Safari" = 1569813296;
      };
    };
  };
}
