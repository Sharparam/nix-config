{ inputs, lib, ... }:
{
  flake-file.inputs.emacs-overlay = {
    url = lib.mkDefault "github:nix-community/emacs-overlay";
    inputs.nixpkgs.follows = lib.mkDefault "nixpkgs";
  };

  den.aspects.apps.provides.emacs = {
    darwin =
      { pkgs, ... }:
      {
        nixpkgs.overlays = [ inputs.emacs-overlay.overlays.default ];

        environment.systemPackages = builtins.attrValues {
          inherit (pkgs)
            ## Emacs
            binutils
            # emacs # We're using emacs-plus from Homebrew

            ## Doom
            ripgrep
            gnutls

            ## Optional
            fd
            imagemagick
            pinentry-emacs
            zstd

            ## Module deps
            # :term vterm
            cmake
            gcc
            gnumake

            # :tools editorconfig
            editorconfig-core-c
            # :lang org +roam
            graphviz
            sqlite
            # :lang sh
            shellcheck
            shfmt
            # :tools lsp
            nodejs

            # Seems to be needed since emacs v30
            tree-sitter
            ;

          inherit (pkgs.emacsPackages)
            vterm
            ;
        };

        homebrew = {
          taps = [ "d12frosted/emacs-plus" ];
          brews = [
            {
              name = "emacs-plus";
              args = [ "with-native-comp" ];
            }
          ];
        };
      };

    homeManager =
      { config, lib, ... }:
      let
        inherit (config.lib.file) mkOutOfStoreSymlink;
      in
      {
        xdg.configFile."doom".source =
          mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/github.com/Sharparam/nix-config/dotfiles/doom/.config/doom";

        # programs = {
        #   bash.initExtra = ''
        #     emacs() {
        #       pgrep emacs Emacs && emacsclient --no-wait --create-frame "$@" || emacs --no-window-system "$@"
        #     }
        #   '';

        #   zsh.siteFunctions = {
        #     emacs = ''
        #       pgrep emacs Emacs && emacsclient --no-wait --create-frame "$@" || emacs --no-window-system "$@"
        #     '';
        #   };
        # };

        home.sessionPath = [
          "\${XDG_CONFIG_HOME:-$HOME/.config}/emacs/bin"
        ];

        home.shellAliases = {
          emacs = "emacsclient --no-wait --create-frame";
        };
      };
  };
}
