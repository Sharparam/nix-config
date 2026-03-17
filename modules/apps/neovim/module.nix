{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  den.aspects.apps.provides.neovim = {
    homeManager =
      { config, pkgs, ... }:
      let
        inherit (config.home) homeDirectory;
        inherit (config.lib.file) mkOutOfStoreSymlink;
      in
      {
        xdg.configFile."nvim".source =
          mkOutOfStoreSymlink "${homeDirectory}/repos/github.com/Sharparam/nix-config/dotfiles/nvim/.config/nvim";

        home.sessionVariables.VISUAL = mkDefault "nvim";
        systemd.user.sessionVariables.VISUAL = mkDefault "nvim";

        programs.neovim = {
          enable = true;
          defaultEditor = true;
          viAlias = true;
          vimAlias = true;
          vimdiffAlias = true;
          withNodeJs = true;
          extraPackages = builtins.attrValues {
            inherit (pkgs)
              unzip
              cargo
              rustc
              gcc
              ;
          };
        };
      };
  };
}
