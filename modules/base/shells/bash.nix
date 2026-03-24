{ lib, ... }:
{
  den.aspects.base = {
    homeManager =
      { pkgs, ... }:
      {
        programs.bash = {
          enable = lib.mkDefault true;
          package = lib.mkDefault pkgs.bashInteractive;
          enableVteIntegration = true;
        };
      };
  };
}
