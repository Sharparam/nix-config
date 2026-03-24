{
  den.aspects.sharparam.provides.secrets = {
    homeManager = {
      sops.secrets = {
        nix-access-tokens = {
          sopsFile = ./secrets.yaml;
        };
      };
    };
  };
}
