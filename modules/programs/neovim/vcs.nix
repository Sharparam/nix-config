let
  nvf.settings.vim = {
    git.enable = true;
  };
in
{
  programs.neovim = {
    homeManager = {
      programs = { inherit nvf; };
    };
  };
}
