let
  hostname = "NINETECH-617128";
  username = "sharparam";
  identifier = "${username}@${hostname}";
in
{
  den.aspects."${identifier}".provides.secrets = {
    homeManager.sops.secrets = {
      "radicle/passphrase".sopsFile = ./secrets.yaml;
      "radicle/public-key".sopsFile = ./secrets.yaml;
      "radicle/private-key".sopsFile = ./secrets.yaml;
    };
  };
}
