{
  programs.kde-connect = {
    nixos = {
      programs.kdeconnect = {
        enable = true;
      };
    };
    darwin = {
      homebrew.masApps = {
        "KDE Connect" = 1580245991;
      };
    };
    homeManager =
      { lib, pkgs, ... }:
      lib.mkIf (!pkgs.stdenv.hostPlatform.isDarwin) {
        services.kdeconnect = {
          enable = true;
          indicator = lib.mkDefault true;
        };
      };
  };
}
