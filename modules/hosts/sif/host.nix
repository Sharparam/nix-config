{
  __findFile,
  inputs,
  ...
}: {
  den.hosts.x86_64-linux.sif = {
    users = {
      sharparam = {};
    };
  };

  den.aspects.sif = {
    includes = [
      <base>
      <boot/systemd-boot>
      <desktops/greetd>
      <desktops/niri>
    ];
    provides.to-users.includes = [
      <desktops/niri>
    ];
    nixos = {pkgs, ...}: {
      imports = [
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x260
        # Include the results of the hardware scan.
        ./_hardware-configuration.nix
      ];

      # Use latest kernel.
      boot.kernelPackages = pkgs.linuxPackages_latest;

      networking.hostName = "sif"; # Define your hostname.
      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

      # Configure network proxy if necessary
      # networking.proxy.default = "http://user:password@proxy:port/";
      # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

      # Enable networking
      networking.networkmanager.enable = true;

      services.openssh.enable = false;

      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users.sharparam = {
        isNormalUser = true;
        description = "Adam Hellberg";
        extraGroups = ["networkmanager" "wheel"];
      };

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "25.11"; # Did you read the comment?
    };

    homeManager = {pkgs, ...}: {
    };
  };
}
