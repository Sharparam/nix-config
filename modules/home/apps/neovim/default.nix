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
  cfg = config.${namespace}.apps.neovim;
in
{
  options.${namespace}.apps.neovim = with types; {
    enable = mkEnableOption "Enable Neovim";
    configPath =
      mkOpt str
        "${config.home.homeDirectory}/repos/github.com/Sharparam/nix-config/dotfiles/nvim/.config/nvim"
        "Path to Neovim configuration folder.";
  };

  config = mkIf cfg.enable {
    xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink cfg.configPath;

    home.sessionVariables.VISUAL = mkDefault "nvim";

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      extraPackages = with pkgs; [
        unzip
        cargo
        rustc
        gcc
      ];
    };
  };
}
