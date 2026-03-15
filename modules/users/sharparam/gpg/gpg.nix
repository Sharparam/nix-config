let
  keyId = "C58C41E27B00AD04";
in
{
  den.aspects.sharparam.provides.gpg = {
    homeManager = {
      programs.gpg = {
        publicKeys = [
          {
            source = ./sharparam.asc;
            trust = "ultimate";
          }
        ];
        settings =
          let
            prefixed = "0x${keyId}";
          in
          {
            default-key = prefixed;
            trusted-key = prefixed;
          };
      };
    };
  };
}
