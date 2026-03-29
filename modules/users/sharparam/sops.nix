{
  den.aspects.sharparam.provides.secrets = {
    homeManager = {
      sops.secrets = {
        nix-access-tokens.sopsFile = ./secrets.yaml;
        op-a-family-id.sopsFile = ./secrets.yaml;
        op-a-family-v-private-id.sopsFile = ./secrets.yaml;
        op-a-work-id.sopsFile = ./secrets.yaml;
        op-a-work-v-employee-id.sopsFile = ./secrets.yaml;
      };
    };
  };
}
