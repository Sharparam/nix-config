{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.services.openssh;
in
{
  options.${namespace}.services.openssh = {
    enable = mkEnableOption "OpenSSH service";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;

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
}
