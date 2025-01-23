{
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
{
  imports = [
    ./hardware-configuration.nix
  ];

  # networking.hostname = "nixos";

  ${namespace} = {
    archetypes = {
      workstation = enabled;
    };

    user = {
      extraGroups = [ "networkmanager" ];
    };
    system = {
      boot.grub = enabled;
      xkb.eu = enabled;
    };
  };

  # Bootloader
  boot.loader.grub.device = "/dev/vda";

  # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.

  services.xserver.videoDrivers = [ "qxl" ];

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  xdg.autostart.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    kate
    wget
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
