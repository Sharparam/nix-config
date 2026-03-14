{
  lib,
  pkgs,
  inputs,
  namespace,
  system,
  config,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    optional
    types
    ;
  cfg = config.${namespace}.system.fonts;
in
{
  options.${namespace}.system.fonts = {
    enable = mkEnableOption "Whether or not to manage fonts.";
    fonts = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Custom font packages to install.";
    };
  };

  config = mkIf cfg.enable {
    environment.variables = {
      LOG_ICONS = "true";
    };

    fonts = {
      packages =

        builtins.attrValues {
          inherit (pkgs)
            corefonts

            jetbrains-mono

            meslo-lgs-nf

            noto-fonts
            noto-fonts-cjk-sans
            noto-fonts-cjk-serif
            noto-fonts-color-emoji

            roboto
            ;

          inherit (pkgs.nerd-fonts)
            caskaydia-cove
            hack
            iosevka
            symbols-only
            ;

          inherit (pkgs.snix)
            nonicons-bin
            ;

          iosevka-sharpie = inputs.iosevka.packages.${system}.bin;
        }
        ++ cfg.fonts;
    };
  };
}
