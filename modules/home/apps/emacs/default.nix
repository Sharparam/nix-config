{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.emacs;
in {
  options.${namespace}.apps.emacs = with types; {
    enable = mkEnableOption "Enable emacs";
  };

  config = mkIf cfg.enable {
    xdg.configFile."doom".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/github.com/Sharparam/nix-config/dotfiles/doom/.config/doom";
  };
}
