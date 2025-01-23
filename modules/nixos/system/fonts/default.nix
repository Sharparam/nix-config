{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.system.fonts;
in
{
  options.${namespace}.system.fonts = {
    enable = mkEnableOption "${namespace}.config.fonts.enable";
    fonts = mkOpt (listOf package) [ ] "Custom font packages to install.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ font-manager ];
    fonts = {
      enableDefaultPackages = true;
      packages =
        with pkgs;
        [
          corefonts
          jetbrains-mono
          meslo-lgs-nf
          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-cjk-serif
          noto-fonts-emoji
          roboto
        ]
        ++ cfg.fonts;
    };
  };
}
