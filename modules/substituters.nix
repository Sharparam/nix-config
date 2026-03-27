# Extra substituters that don't fit in a specific file
let
  substituters = [
    "https://crane.cachix.org"
  ];

  trusted-public-keys = [
    "crane.cachix.org-1:8Scfpmn9w+hGdXH/Q9tTLiYAE/2dnJYRJP7kl80GuRk="
  ];

  nix.settings = {
    inherit substituters trusted-public-keys;
  };
in
{
  den.default = {
    os = {
      inherit nix;
    };

    homeManager = {
      inherit nix;
    };
  };
}
