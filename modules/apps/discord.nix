{
  den.aspects.apps.provides.discord = {
    homeManager =
      { lib, ... }:
      {
        programs.vesktop = {
          enable = lib.mkDefault true;
        };
      };
  };
}
