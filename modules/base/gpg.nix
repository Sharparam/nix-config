{ lib, ... }:
let
  inherit (lib) mkDefault;

  agentSettings = {
    default-cache-ttl = 60;
    default-cache-ttl-ssh = 60;
    max-cache-ttl = 120;
    max-cache-ttl-ssh = 120;
    min-passphrase-len = 64;
  };

  homeAgentConfig = ''
    default-cache-ttl ${toString agentSettings.default-cache-ttl}
    default-cache-ttl-ssh ${toString agentSettings.default-cache-ttl-ssh}
    max-cache-ttl ${toString agentSettings.max-cache-ttl}
    max-cache-ttl-ssh ${toString agentSettings.max-cache-ttl-ssh}
    min-passphrase-len ${toString agentSettings.min-passphrase-len}
  '';
in
{
  den.aspects.base = {
    os = {
      programs = {
        gnupg.agent = {
          enable = mkDefault true;
          enableSSHSupport = mkDefault false;
        };
      };
    };

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [
          pkgs.pinentry-curses
        ];

        services.pcscd.enable = true;

        programs = {
          gnupg.agent = {
            # Settings are only supported on NixOS
            settings = agentSettings;
          };
        };
      };

    homeManager =
      { config, ... }:
      let
        cfg = config.programs.gpg;
      in
      {
        home.file."${cfg.homedir}/gpg-agent.conf".text = homeAgentConfig;
        programs.gpg = {
          enable = mkDefault true;
          scdaemonSettings = {
            disable-ccid = true;
            card-timeout = "1";
            reader-port = "Yubico YubiKey OTP+FIDO+CCID 00 00";
          };
          settings = {
            # UTF-8 support for compatibility
            charset = "utf-8";
            # Disable banner
            no-greeting = true;
            # Display key origins and updates
            # with-key-origin = true;
            # Output ASCII instead of binary
            armor = true;
            # Enable smartcard
            use-agent = true;
            # Disable recipient key ID in messages (breaks Mailvelope)
            #throw-keyids = true;
            # Group recipient keys (preferred ID last)
            #group keygroup = 0xFF00000000000003 0xFF00000000000002 0xFF00000000000001
            # Keyserver URL
            #keyserver hkps://keys.openpgp.org
            #keyserver hkps://keys.mailvelope.com
            #keyserver hkps://keyserver.ubuntu.com:443
            #keyserver hkps://pgpkeys.eu
            #keyserver hkps://pgp.circl.lu
            #keyserver hkp://zkaan2xfbuxia2wpf7ofnkbz6r5zdbbvxbunvp5g2iebopbfc4iqmbad.onion
            # Keyserver proxy
            #keyserver-options http-proxy=http://127.0.0.1:8118
            #keyserver-options http-proxy=socks5-hostname://127.0.0.1:9050
            # Enable key retrieval using WKD and DANE
            auto-key-locate = "local,wkd,dane,keyserver";
            #auto-key-retrieve = true;
            # Trust delegation mechanism
            #trust-model = "tofu+pgp";
            # Show expired subkeys
            #list-options = "show-unusable-subkeys";
            # Verbose output
            #verbose = true;
          };
        };
      };
  };
}
