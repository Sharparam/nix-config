{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  cfg = config.${namespace}.security.gpg;
in
{
  options.${namespace}.security.gpg = {
    enable = mkEnableOption "GPG";
    enableSSHSupport = mkOption {
      type = types.bool;
      default = false;
      description = "Enable SSH support";
    };
  };

  config = mkIf cfg.enable {
    programs = {
      # TODO: Not supported on nix-darwin
      # ssh.startAgent = mkIf cfg.enableSSHSupport false;
      gnupg.agent = {
        enable = true;
        inherit (cfg) enableSSHSupport;
        # TODO: settings not supported on nix-darwin
        # settings = {
        #   default-cache-ttl = 60;
        #   default-cache-ttl-ssh = 60;
        #   max-cache-ttl = 120;
        #   max-cache-ttl-ssh = 120;
        #   min-passphrase-len = 64;
        # };
      };
    };
  };
}
