{ pkgs, ... }:
{
  imports = [
    ./configuration.nix
    ../../modules/nixos/user
  ];

  sharparam.user = {
    enable = true;
    extraGroups = [ "networkmanager" ];
  };

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
    wget
  ];

  # List services that you want to enable:

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable touchpad support (enabled default in most desktopManager)
  # services.xserver.libinput.enable = true;

  users.users.sharparam.packages = with pkgs; [
    kdePackages.kate
    # thunderbird
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
  home-manager.users.sharparam =
    {
      pkgs,
      lib,
      inputs,
      config,
      ...
    }:
    {
      imports = [
        ../../modules/hm/cli.nix
      ];
    };
}
