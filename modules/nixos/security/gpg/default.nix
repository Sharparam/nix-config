{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.security.gpg;
in
{
  options.${namespace}.security.gpg = {
    enable = mkEnableOption "GPG";
    enableSSHSupport = mkEnableOption "SSH support";
  };

  config = mkIf cfg.enable {
    services.pcscd.enable = true;

    environment.systemPackages = [
      pkgs.pinentry-curses
    ];

    programs = {
      ssh.startAgent = mkIf cfg.enableSSHSupport false;
      gnupg.agent = {
        enable = true;
        inherit (cfg) enableSSHSupport;
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
}
