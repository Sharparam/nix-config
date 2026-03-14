{
  den.aspects.base = {
    homeManager =
      { lib, pkgs, ... }:
      {
        programs.nushell = {
          enable = true;
          package = lib.mkDefault pkgs.nushell;
        };
      };
  };
}
