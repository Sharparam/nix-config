{ lib, ... }:
let
  settings = {
    background = "dark";
    expandtab = true;
    number = true;
    relativenumber = true;
    shiftwidth = 4;
    tabstop = 4;
  };
in
{
  den.aspects.base = {
    os.programs.vim.enable = true;

    homeManager =
      { config, pkgs, ... }:
      let
        inherit (pkgs) vimPlugins;
      in
      {
        xdg.configFile = {
          "vim/pack/nix/start/catppuccin-vim".source = vimPlugins.catppuccin-vim;
          "vim/pack/nix/start/editorconfig-vim".source = vimPlugins.editorconfig-vim;
          "vim/pack/nix/start/vim-sensible".source = vimPlugins.vim-sensible;
          "vim/vimrc".text = lib.mkMerge [
            ''
              set background=${settings.background}
              set ${if settings.expandtab then "" else "no"}expandtab
              set ${if settings.number then "" else "no"}number
              set ${if settings.relativenumber then "" else "no"}relativenumber
              set shiftwidth=${toString settings.shiftwidth}
              set tabstop=${toString settings.tabstop}
            ''
            (builtins.readFile ./vimrc)
            "colorscheme catppuccin_${config.catppuccin.flavor}"
          ];
        };
        programs.vim = {
          inherit settings;
          enable = true;
          plugins = builtins.attrValues {
            inherit (pkgs.vimPlugins)
              catppuccin-vim
              editorconfig-vim
              vim-sensible
              ;
          };
          extraConfig = lib.mkMerge [
            (builtins.readFile ./vimrc)
            "colorscheme catppuccin_${config.catppuccin.flavor}"
          ];
        };
      };
  };
}
