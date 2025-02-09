{
  lib,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.system.fonts;
in
{
  imports = [ (lib.snowfall.fs.get-file "modules/shared/system/fonts/default.nix") ];

  config = mkIf cfg.enable {
    system.defaults.NSGlobalDomain.AppleFontSmoothing = 1;

    homebrew = {
      casks = [
        "font-sf-pro"
        "sf-symbols"
      ];
    };
  };
}
