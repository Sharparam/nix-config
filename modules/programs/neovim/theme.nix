{
  programs.neovim = {
    homeManager =
      { config, ... }:
      {
        programs.nvf.settings.vim.theme = {
          enable = true;
          name = "catppuccin";
          style = config.catppuccin.flavor;
        };
      };
  };
}
