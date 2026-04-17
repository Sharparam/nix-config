{lib, ...}: {
  den.aspects.desktops.provides.greetd = {
    nixos = {
      services.greetd = {
        enable = lib.mkDefault true;
        useTextGreeter = lib.mkDefault true;
      };
    };
  };
}
