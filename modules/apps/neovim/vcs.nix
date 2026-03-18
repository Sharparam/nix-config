let
  nvf.settings.vim = {
    git.enable = true;
  };
in
{
  den.aspects.apps.provides.neovim = {
    homeManager = {
      programs = { inherit nvf; };
    };
  };
}
