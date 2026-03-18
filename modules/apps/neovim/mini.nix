let
  nvf.settings.vim.mini = {
    ai.enable = true;
    bracketed.enable = true;
    icons.enable = true;
    indentscope.enable = true;
    surround.enable = true;
  };
in
{
  den.aspects.apps.provides.neovim = {
    homeManager = {
      programs = { inherit nvf; };
    };
  };
}
