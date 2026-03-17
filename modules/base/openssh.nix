{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  den.aspects.base = {
    nixos = {
      services.openssh = {
        enable = mkDefault true;

        hostKeys = mkDefault [
          {
            path = "/etc/ssh/ssh_host_rsa_key";
            type = "rsa";
            bits = 4096;
          }
          {
            path = "/etc/ssh/ssh_host_ed25519_key";
            type = "ed25519";
            bits = 4096;
          }
        ];

        ports = mkDefault [ 22 ];

        settings = {
          AuthenticationMethods = "publickey";
          PasswordAuthentication = false;
          # TODO: How to do format and "install-iso" in den?
          # PermitRootLogin = if format == "install-iso" then "yes" else "no";
          PermitRootLogin = "no";
          PubkeyAuthentication = "yes";
          UsePAM = true;
          X11Forwarding = false;
        };

        startWhenNeeded = true;
      };
    };

    darwin = {
      services.openssh = {
        enable = mkDefault true;

        # TODO: Not supported on nix-darwin
        # hostKeys = mkDefault [
        #   {
        #     path = "/etc/ssh/ssh_host_rsa_key";
        #     type = "rsa";
        #     bits = 4096;
        #   }
        #   {
        #     path = "/etc/ssh/ssh_host_ed25519_key";
        #     type = "ed25519";
        #     bits = 4096;
        #   }
        # ];
      };
    };
  };
}
