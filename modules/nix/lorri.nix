{
  den.default = {
    os = {
      services.lorri.enable = true;
    };

    homeManager =
      { pkgs, ... }:
      {
        services.lorri = {
          enable = true;
          nixPackage = pkgs.lixPackageSets.latest.lix;
        };
      };
  };
}
