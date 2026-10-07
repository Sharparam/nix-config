let
  hostname = "sif";
  username = "sharparam";
  identifier = "${username}@${hostname}";
in
{
  den.aspects."${identifier}".provides.secrets = {
    homeManager = { config, ... }: {
      sops.secrets = {
        "radicle/passphrase".sopsFile = ./secrets.yaml;
        "radicle/public-key".sopsFile = ./secrets.yaml;
        "radicle/private-key".sopsFile = ./secrets.yaml;
        "u2f_keys" = {
          sopsFile = ./secrets.yaml;
          mode = "0400";
          path = "${config.xdg.configHome}/Yubico/u2f_keys";
        };
      };
    };
  };
}
