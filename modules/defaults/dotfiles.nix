{
  den.default = {
    homeManager =
      { config, ... }:
      let
        inherit (config.lib.file) mkOutOfStoreSymlink;
        path = "${config.home.homeDirectory}/repos/github.com/Sharparam/nix-config/dotfiles";
      in
      {
        xdg.configFile = {
          "ideavim/ideavimrc".source = mkOutOfStoreSymlink "${path}/intellij/.ideavimrc";
        };
      };
  };
}
