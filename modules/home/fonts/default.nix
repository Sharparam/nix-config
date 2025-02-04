{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
with lib.home-manager;
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

    home.activation.ensureDummyFontConfig = hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p "$HOME/.config/fontconfig/conf.d"
      run cp $VERBOSE_ARG ${builtins.toPath ./00-dummy.conf} "$HOME/.config/fontconfig/conf.d/00-dummy.conf"
    '';
  };
}
