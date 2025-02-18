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
    environment.systemPackages = with pkgs; [
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
      sqlite
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
