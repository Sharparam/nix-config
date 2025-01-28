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
  cfg = config.${namespace}.dotfiles;
in
{
  options.${namespace}.dotfiles = with types; {
    enable = mkEnableOption "Enable dotfiles";
    dotfilesPath =
      mkOpt str "${config.home.homeDirectory}/repos/github.com/Sharparam/nix-config/dotfiles"
        "Path to dotfiles folder.";
  };

  config = mkIf cfg.enable {
    xdg.configFile."dotfiles".source = config.lib.file.mkOutOfStoreSymlink cfg.dotfilesPath;
  };
}
