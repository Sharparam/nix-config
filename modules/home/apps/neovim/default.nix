{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib)
    mkDefault
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  cfg = config.${namespace}.apps.neovim;
in
{
  options.${namespace}.apps.neovim = {
    enable = mkEnableOption "Neovim";
    configPath = mkOption {
      type = types.str;
      default = "${config.home.homeDirectory}/repos/github.com/Sharparam/nix-config/dotfiles/nvim/.config/nvim";
      description = "Path to Neovim configuration folder.";
    };
  };

  config = mkIf cfg.enable {
    xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink cfg.configPath;

    home.sessionVariables.VISUAL = mkDefault "nvim";
    systemd.user.sessionVariables.VISUAL = mkDefault "nvim";

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      extraPackages = builtins.attrValues {
        inherit (pkgs)
          unzip
          cargo
          rustc
          gcc
          ;
      };
    };
  };
}
