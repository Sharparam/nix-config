let
  substituters = [
    "https://nix-community.cachix.org"
  ];

  trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

  settings = {
    inherit substituters trusted-public-keys;
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
        inherit settings;
      };
    };
  };
}
