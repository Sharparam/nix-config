{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.sublime-merge;
in {
  options.${namespace}.apps.sublime-merge = with types; {
    enable = mkEnableOption "Sublime Merge";
  };

  config = mkIf cfg.enable {
    homebrew = {
      casks = ["sublime-merge"];
    };
  };
}
