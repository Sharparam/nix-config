{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  den.aspects.base = {
    os = {
      programs = {
        gnupg.agent = {
          enable = mkDefault true;
          enableSSHSupport = mkDefault false;
        };
      };
    };

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [
          pkgs.pinentry-curses
        ];

        services.pcscd.enable = true;

        programs = {
          gnupg.agent = {
            # Settings are only supported on NixOS
            settings = {
              default-cache-ttl = 60;
              default-cache-ttl-ssh = 60;
              max-cache-ttl = 120;
              max-cache-ttl-ssh = 120;
              min-passphrase-len = 64;
            };
          };
        };
      };
  };
}
