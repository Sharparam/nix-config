{
  lib,
  pkgs,
  inputs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.security.gpg;
in
{
  options.${namespace}.security.gpg = with types; {
    enable = mkEnableOption "Enable GPG";
    enableSSHSupport = mkBoolOpt false "Enable SSH support";
  };

  config = mkIf cfg.enable {
    services.pcscd = enabled;

    environment.systemPackages = with pkgs; [
      pinentry-curses
    ];

    programs = {
      ssh.startAgent = mkIf cfg.enableSSHSupport false;
      gnupg.agent = {
        enable = true;
        enableSSHSupport = cfg.enableSSHSupport;
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
