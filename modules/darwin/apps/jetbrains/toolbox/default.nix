{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.apps.jetbrains.toolbox;
in
{
  options.${namespace}.apps.jetbrains.toolbox = {
    enable = mkEnableOption "JetBrains Toolbox";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = [
    #   pkgs.jetbrains-toolbox
    # ];

    homebrew = {
      casks = [ "jetbrains-toolbox" ];
    };
  };
}
