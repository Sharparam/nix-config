{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.emacs;
in {
  options.${namespace}.apps.emacs = with types; {
    enable = mkEnableOption "Enable emacs";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; let
      epkgs = pkgs.emacsPackages;
    in [
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
      epkgs.vterm
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
    ];

    homebrew = {
      taps = ["d12frosted/emacs-plus"];
      brews = [
        {
          name = "emacs-plus";
          args = ["with-native-comp"];
        }
      ];
    };
  };
}
