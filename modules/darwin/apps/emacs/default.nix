{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.${namespace}.apps.emacs;
in
{
  options.${namespace}.apps.emacs = {
    enable = lib.mkEnableOption "emacs";
  };

  config = mkIf cfg.enable {
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
}
