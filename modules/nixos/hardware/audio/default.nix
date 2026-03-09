{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.hardware.audio;
in
{
  options.${namespace}.hardware.audio = {
    enable = mkEnableOption "pipewire";
  };

  config = mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };

      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    environment.systemPackages = [ pkgs.pavucontrol ];
  };
}
