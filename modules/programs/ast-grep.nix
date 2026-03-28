{
  programs.ast-grep = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.ast-grep ];

        home.shellAliases = {
          sg = "ast-grep";
        };
      };
  };
}
