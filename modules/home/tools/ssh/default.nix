{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
with lib.home-manager; let
  cfg = config.${namespace}.tools.ssh;
in {
  options.${namespace}.tools.ssh = {
    enable = mkEnableOption "SSH";
    useYubiKey = mkBoolOpt false "Use YubiKey for auth";
    identityFile = mkOption {
      type = with types; either (listOf str) (nullOr str);
      default = ["~/.ssh/id_yubikey_gpg.pub"];
      apply = p:
        if p == null
        then []
        else if isString p
        then [p]
        else p;
      description = ''
        Specifies files from which the user identity is read.
        Identities will be tried in the given order.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.file.".ssh/allowed_signers".source = ../../../../dotfiles/ssh/.ssh/allowed_signers;
    home.file.".ssh/id_yubikey_gpg.pub".source = ./id_yubikey_gpg.pub;
    home.activation.createSshHomeDir = hm.dag.entryBetween ["linkGeneration"] ["writeBoundary"] ''
      run mkdir $VERBOSE_ARG -m700 -p "$HOME/.ssh"
      run mkdir $VERBOSE_ARG -m700 -p "$HOME/.ssh/control"
    '';
    programs.ssh = {
      enable = true;
      controlMaster = "auto";
      controlPath = "~/.ssh/control/%r@%h:%p";
      controlPersist = "5m";
      matchBlocks = with lib.home-manager.hm.dag; {
        servers = {
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
        solaire = entryAfter ["servers"] {
          port = 987;
        };
        shanalotte = entryAfter ["servers"] {
          port = 987;
        };
        matrix = entryAfter ["servers"] {
          port = 987;
        };
        radahn = entryAfter ["servers"] {
          port = 22;
        };
        aur = {
          hostname = "aur.archlinux.org";
          user = "aur";
        };
        "ssh.dev.azure.com" = mkIf cfg.useYubiKey {
          identitiesOnly = true;
          identityFile = cfg.identityFile;
        };
        sol_lan = {
          host = "*.sol.lan";
          forwardAgent = true;
        };
        sol = entryAfter ["sol_lan" "solaire"] {
          host = "sol*";
          hostname = "%h.sol.lan";
          forwardAgent = true;
        };
      };
    };
  };
}
