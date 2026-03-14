let
  lsdAliases = lsd: {
    ls = "${lsd}/bin/lsd --group-dirs first";
    l = "ls --online --all";
    ll = "ls --long";
    la = "ls --all";
    lt = "ls --tree";
  };
in
{
  den.aspects.base = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.lsd ];

        # The lsd aliases won't work in nushell, so we set them for the non-nushell
        # shells we use here.
        programs.bash.shellAliases = lsdAliases "lsd";
        programs.zsh.shellAliases = lsdAliases "lsd";
      };

  };
}
