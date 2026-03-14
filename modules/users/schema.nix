let
  defaultFullName = "Adam Hellberg";
  defaultEmail = "sharparam@sharparam.com";
  _1PasswordPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAZcQxmr5ZfF/d0YqEZfhr0ZjuHUjxKBf7YgVjYqS+gE";
  gpgKeyId = "C58C41E27B00AD04";
  defaultGitSigningKey = "key::${_1PasswordPublicKey}";
  defaultJjSigningKey = _1PasswordPublicKey;
  defaultAuthorizedKeys = [
    _1PasswordPublicKey
  ];
  userHomeOptions =
    lib:
    let
      inherit (lib) mkOption types;
    in
    {
      fullName = mkOption {
        type = types.str;
        default = defaultFullName;
      };
      email = mkOption {
        type = types.str;
        default = defaultEmail;
      };
      git = mkOption {
        type = types.attrsOf (
          types.submodule {
            options = {
              signingKey = mkOption {
                type = types.nullOr types.str;
                default = defaultGitSigningKey;
              };
            };
          }
        );
      };
      jujutsu = mkOption {
        type = types.attrsOf (
          types.submodule {
            options = {
              signingKey = mkOption {
                type = types.nullOr types.str;
                default = defaultJjSigningKey;
              };
            };
          }
        );
      };
      gpg = mkOption {
        type = types.attrsOf (
          types.submodule {
            options = {
              keyId = mkOption {
                type = types.nullOr types.str;
                default = gpgKeyId;
              };
            };
          }
        );
      };
      ssh = mkOption {
        type = types.attrsOf (
          types.submodule {
            options = {
              publicKey = mkOption {
                type = types.str;
                default = _1PasswordPublicKey;
              };
              authorizedKeys = mkOption {
                type = types.listOf types.str;
                default = defaultAuthorizedKeys;
              };
            };
          }
        );
      };
    };
in
{
  den.schema.user =
    { lib, ... }:
    {
      options = lib.mkMerge [
        (userHomeOptions lib)
      ];

      config =
        let
          inherit (lib) mkDefault;
        in
        {
          fullName = mkDefault defaultFullName;
          email = mkDefault defaultEmail;
          git.signingKey = mkDefault defaultGitSigningKey;
          jujutsu.signingKey = mkDefault defaultJjSigningKey;
          gpg.keyId = mkDefault gpgKeyId;
          ssh = {
            publicKey = mkDefault _1PasswordPublicKey;
            authorizedKeys = mkDefault defaultAuthorizedKeys;
          };
        };
    };

  den.schema.home =
    { lib, ... }:
    {
      options = lib.mkMerge [
        (userHomeOptions lib)
      ];

      config =
        let
          inherit (lib) mkDefault;
        in
        {
          fullName = mkDefault defaultFullName;
          email = mkDefault defaultEmail;
          git.signingKey = mkDefault defaultGitSigningKey;
          jujutsu.signingKey = mkDefault defaultJjSigningKey;
          gpg.keyId = mkDefault gpgKeyId;
          ssh = {
            publicKey = mkDefault _1PasswordPublicKey;
            authorizedKeys = mkDefault defaultAuthorizedKeys;
          };
        };
    };
}
