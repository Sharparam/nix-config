{
  den.aspects."sharparam@melina".provides.secrets = {
    homeManager.sops.secrets = {
      "radicle/passphrase".sopsFile = ./secrets.yaml;
      "radicle/public-key".sopsFile = ./secrets.yaml;
      "radicle/private-key".sopsFile = ./secrets.yaml;
    };
  };
}
