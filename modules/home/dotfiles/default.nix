{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  cfg = config.${namespace}.dotfiles;
in
{
  options.${namespace}.dotfiles = {
    enable = mkEnableOption "dotfiles";
    dotfilesPath = mkOption {
      type = types.str;
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
