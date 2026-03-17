let
  substituters = [
    "https://nix-community.cachix.org"
  ];

  trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

  extra-home-substituters = [
    "https://cache.nixos.org"
  ];

  extra-home-trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  ];

  settings = {
    inherit substituters trusted-public-keys;
  };

  homeSettings = {
    substituters = substituters ++ extra-home-substituters;
    trusted-public-keys = trusted-public-keys ++ extra-home-trusted-public-keys;
  };
in
{
  den.default = {
    os = {
      nix = {
        inherit settings;
      };
    };

    homeManager = {
      nix = {
        settings = homeSettings;
      };
    };
  };
}
