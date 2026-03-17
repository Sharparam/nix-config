{ __findFile, ... }:
{
  den.default = {
    os = {
      nixpkgs.config.allowUnfree = true;
    };

    homeManager = {
      home.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
    };
  };
}
