{
  lib,
  pkgs,
  namespace,
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
    enable = mkEnableOption "Enable OpenSSH service";
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
    };
  };
}
