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
  cfg = config.${namespace}.tools.ssh;
in
{
  options.${namespace}.tools.ssh =
    let
      inherit (types)
        bool
        either
        listOf
        nullOr
        str
        ;
    in
    {
      enable = mkEnableOption "SSH";
      useYubiKey = mkOption {
        type = bool;
        default = false;
        description = "Use YubiKey for auth";
      };
      identityFile = mkOption {
        type = either (listOf str) (nullOr str);
        default = [ "~/.ssh/id_yubikey_gpg.pub" ];
        apply =
          p:
          if p == null then
            [ ]
          else if builtins.isString p then
            [ p ]
          else
            p;
        description = ''
          Specifies files from which the user identity is read.
          Identities will be tried in the given order.
        '';
      };
    };

  config = mkIf cfg.enable {
    home.file.".ssh/allowed_signers".source = ../../../../dotfiles/ssh/.ssh/allowed_signers;
    home.file.".ssh/id_yubikey_gpg.pub".source = ./id_yubikey_gpg.pub;
    home.activation.createSshHomeDir =
      lib.home-manager.hm.dag.entryBetween [ "linkGeneration" ] [ "writeBoundary" ]
        ''
          run mkdir $VERBOSE_ARG -m700 -p "$HOME/.ssh"
          run mkdir $VERBOSE_ARG -m700 -p "$HOME/.ssh/control"
        '';
    home.packages = [
      pkgs.mosh
    ];
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks =
        let
          inherit (lib.home-manager.hm.dag) entryAfter;
        in
        {
          "*" = {
            addKeysToAgent = "no";
            compression = false;
            controlMaster = "auto";
            controlPath = "~/.ssh/control/%r@%h:%p";
            controlPersist = "5m";
            forwardAgent = false;
            hashKnownHosts = false;
            serverAliveInterval = 0;
            serverAliveCountMax = 3;
            userKnownHostsFile = "~/.ssh/known_hosts";
          };
          servers = entryAfter [ "*" ] {
            host = "solaire shanalotte matrix radahn";
            hostname = "%h.sharparam.com";
            user = "sharparam";
            forwardAgent = true;
            extraOptions = {
              PasswordAuthentication = "no";
              VerifyHostKeyDNS = "yes";
            };
          };
          # // (mkIf cfg.useYubiKey {
          #   identitiesOnly = true;
          #   identityFile = cfg.identityFile;
          # });
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
          "ssh.dev.azure.com" = mkIf cfg.useYubiKey {
            identitiesOnly = true;
            inherit (cfg) identityFile;
          };
          sol_lan = {
            host = "*.sol.lan";
            forwardAgent = true;
          };
          sol = entryAfter [ "sol_lan" "solaire" ] {
            host = "sol*";
            hostname = "%h.sol.lan";
            forwardAgent = true;
          };
        };
    };
  };
}
