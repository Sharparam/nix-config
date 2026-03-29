{ inputs, lib, ... }:
{
  flake-file.inputs.locale-en_se = {
    url = lib.mkDefault "github:Sharparam/locale-en_se/main";
    inputs.nixpkgs.follows = lib.mkDefault "nixpkgs";
  };

  den.default = {
    includes = [
      (
        { home }:
        {
          homeManager =
            { inputs', ... }:
            let
              glibcLocales = inputs'.locale-en_se.packages.glibcLocales;
            in
            {
              i18n.glibcLocales = glibcLocales.override {
                allLocales = false;
                locales = [
                  "C.UTF-8/UTF-8"
                  "en_DK.UTF-8/UTF-8"
                  "en_GB.UTF-8/UTF-8"
                  "en_SE.UTF-8/UTF-8"
                  "en_US.UTF-8/UTF-8"
                  "sv_SE.UTF-8/UTF-8"
                ];
              };
            };
        }
      )
    ];

    nixos = {
      imports = [
        inputs.locale-en_se.nixosModules.default
      ];
    };
  };
}
