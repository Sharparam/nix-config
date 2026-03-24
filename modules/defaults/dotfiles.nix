{
  den.default = {
    homeManager =
      { config, ... }:
      let
        inherit (config.lib.file) mkOutOfStoreSymlink;
        path = "${config.home.homeDirectory}/repos/github.com/Sharparam/nix-config/dotfiles";
        dotfiles = mkOutOfStoreSymlink path;
      in
      {
        home.file.".dotfiles".source = dotfiles;
        xdg.configFile = {
          "ideavim/ideavimrc".source = "${dotfiles}/intellij/.ideavimrc";
        };
      };
  };
}
