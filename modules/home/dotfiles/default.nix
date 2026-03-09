{
  lib,
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
    dotfilesPath = mkOption {
      type = str;
      default = "${config.home.homeDirectory}/repos/github.com/Sharparam/nix-config/dotfiles";
      description = "Path to dotfiles folder.";
    };
  };

  config = mkIf cfg.enable {
    xdg.configFile = {
      "dotfiles".source = config.lib.file.mkOutOfStoreSymlink cfg.dotfilesPath;
      "ideavim/ideavimrc".source =
        config.lib.file.mkOutOfStoreSymlink "${cfg.dotfilesPath}/intellij/.ideavimrc";
    };
  };
}
