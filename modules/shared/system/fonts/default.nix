{
  lib,
  pkgs,
  inputs,
  namespace,
  system,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.system.fonts;
in {
  options.${namespace}.system.fonts = with types; {
    enable = mkEnableOption "Whether or not to manage fonts.";
    fonts = mkOpt (listOf package) [] "Custom font packages to install.";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      LOG_ICONS = "true";
    };

    fonts = {
      packages = with pkgs;
        [
          corefonts

          jetbrains-mono
          meslo-lgs-nf

          nerd-fonts.caskaydia-cove
          nerd-fonts.hack
          nerd-fonts.iosevka
          nerd-fonts.symbols-only

          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-cjk-serif
          noto-fonts-color-emoji

          roboto

          inputs.iosevka.packages.${system}.bin

          snix.nonicons-bin
        ]
        ++ optional pkgs.stdenv.isDarwin sketchybar-app-font
        ++ cfg.fonts;
    };
  };
}
