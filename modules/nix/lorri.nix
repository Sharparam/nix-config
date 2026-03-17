{
  den.default = {
    os = {
      services.lorri.enable = true;
    };

    homeManager =
      { pkgs, ... }:
      {
        services.lorri = {
          enable = pkgs.stdenv.isLinux;
          nixPackage = pkgs.lixPackageSets.latest.lix;
        };
      };
  };
}
