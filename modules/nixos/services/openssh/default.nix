{
  lib,
  namespace,
  format,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.services.openssh;
in
{
  options.${namespace}.services.openssh = with types; {
    enable = mkEnableOption "OpenSSH";
    authorizedKeys = mkOption {
      type = listOf str;
      default = [ ];
      description = "The public keys to authorize.";
    };
    port = mkOption {
      type = port;
      default = 22;
      description = "The port to listen on.";
    };
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;

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

      ports = [
        cfg.port
      ];

      settings = {
        AuthenticationMethods = "publickey";
        PasswordAuthentication = false;
        PermitRootLogin = if format == "install-iso" then "yes" else "no";
        PubkeyAuthentication = "yes";
        UsePAM = true;
        X11Forwarding = false;
      };

      startWhenNeeded = true;
    };
  };
}
