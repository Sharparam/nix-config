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
  cfg = config.${namespace}.tools.ssh;
in
{
  options.${namespace}.tools.ssh = {
    enable = mkEnableOption "SSH";
    identityFile = mkOption {
      type = with types; either (listOf str) (nullOr str);
      default = [ "~/.ssh/id_yubikey_gpg.pub" ];
      apply =
        p:
        if p == null then
          [ ]
        else if isString p then
          [ p ]
        else
          p;
      description = ''
        Specifies iles from which the user identity is read.
        Identities will be tried in the given order.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.file.".ssh/id_yubikey_gpg.pub".source = ./id_yubikey_gpg.pub;
    home.activation.fixSshPermissions =
      lib.home-manager.hm.dag.entryAfter [ "writeBoundary" "linkGeneration" ]
        ''
          run chmod $VERBOSE_ARG 600 $HOME/.ssh
        '';
    programs.ssh = {
      enable = true;
      controlMaster = "auto";
      controlPath = "~/.ssh/control/%r@%n:%p";
      controlPersist = "5m";
      matchBlocks = with lib.home-manager.hm.dag; {
        servers = {
          host = "solaire shanalotte matrix radahn";
          identitiesOnly = true;
          identityFile = cfg.identityFile;
          hostname = "%h.sharparam.com";
          user = "sharparam";
          extraOptions = {
            PasswordAuthentication = "no";
            VerifyHostKeyDNS = "yes";
          };
        };
        solaire = entryAfter [ "servers" ] {
          port = 987;
        };
        shanalotte = entryAfter [ "servers" ] {
          port = 987;
        };
        matrix = entryAfter [ "servers" ] {
          port = 987;
        };
        radahn = entryAfter [ "servers" ] {
          port = 22;
        };
        aur = {
          hostname = "aur.archlinux.org";
          user = "aur";
        };
        "ssh.dev.azure.com" = {
          identitiesOnly = true;
          identityFile = cfg.identityFile;
        };
      };
    };
  };
}
