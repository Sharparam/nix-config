{
  den.aspects.desktops.provides.noctalia-niri = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [
        pkgs.wl-clipboard
      ];
      services = {
        greetd = {
          useTextGreeter = false;
        };
      };
    };
  };
}
