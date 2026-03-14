{
  den.aspects.base = {
    nixos =
      { pkgs, ... }:
      {
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
  };
}
