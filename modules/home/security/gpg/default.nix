{
  lib,
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
  options.${namespace}.security.gpg = {
    enable = mkEnableOption "Enable GPG";
    defaultKey = mkOpt (nullOr str) "0xC58C41E27B00AD04" "Default key ID";
    trustedKey = mkOpt (nullOr str) "0xC58C41E27B00AD04" "Trusted key ID";
  };

  config = mkIf cfg.enable {
    programs.gpg = {
      enable = true;
      publicKeys = [
        {
          source = ./sharparam.asc;
          trust = "ultimate";
        }
      ];
      scdaemonSettings = {
        disable-ccid = true;
        card-timeout = 1;
        reader-port = "Yubico YubiKey OTP+FIDO+CCID 00 00";
      };
      settings = {
        # Use AES256, 192, or 128 as cipher
        personal-cipher-preferences = "AES256 AES192 AES";
        # Use SHA512, 384, or 256 as digest
        personal-digest-preferences = SHA512 SHA384 SHA256;
        # Use ZLIB, BZIP2, ZIP, or no compression
        personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
        # Default preferences for new keys
        default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
        # SHA512 as digest to sign keys
        cert-digest-algo = "SHA512";
        # SHA512 as digest for symmetric ops
        s2k-digest-algo = "SHA512";
        # AES256 as cipher for symmetric ops
        s2k-cipher-algo = "AES256";
        # UTF-8 support for compatibility
        charset = "utf-8";
        # No comments in messages
        no-comments = true;
        # No version in output
        no-emit-version = true;
        # Disable banner
        no-greeting = true;
        # Long key id format
        keyid-format = "0xlong";
        # Display UID validity
        list-options = "show-uid-validity";
        verify-options = "show-uid-validity";
        # Display all keys and their fingerprints
        with-fingerprint = true;
        # Display key origins and updates
        #with-key-origin = true;
        # Cross-certify subkeys are present and valid
        require-cross-certification = true;
        # Disable caching of passphrase for symmetrical ops
        no-symkey-cache = true;
        # Output ASCII instead of binary
        armor = true;
        # Enable smartcard
        use-agent = true;
        # Disable recipient key ID in messages (breaks Mailvelope)
        #throw-keyids = true;
        # Default key ID to use (helpful with throw-keyids)
        default-key = cfg.defaultKey;
        trusted-key = cfg.trustedKey;
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
}
