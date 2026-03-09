{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.apps.sublime-merge;
in
{
  options.${namespace}.apps.sublime-merge = {
    enable = mkEnableOption "Sublime Merge";
  };

  config = mkIf cfg.enable {
    homebrew = {
      casks = [ "sublime-merge" ];
    };
  };
}
