{
  den.aspects.apps.provides.neovim = {
    homeManager =
      { config, ... }:
      {
        programs.nvf.settings.vim.theme = {
          name = "catppuccin";
          style = config.catppuccin.flavor;
        };
      };
  };
}
