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
  cfg = config.${namespace}.fonts;
in
{
  options.${namespace}.fonts = with types; {
    enable = mkEnableOption "Enable home-manager font management.";
  };

  config = mkIf cfg.enable {
    fonts.fontconfig = {
      enable = true;
    };

    xdg.configFile."fontconfig/conf.d/99-local-fonts.conf".text = ''
      <?xml version="1.0" ?>
      <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
      <fontconfig>
        <dir>~/.local/share/fonts</dir>
      </fontconfig>
    '';
  };
}
