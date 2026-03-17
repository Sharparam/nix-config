{ lib, den, ... }:
let
  inherit (den.lib) take;

  hmAspect = {
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

  homeUserAspect = (take.exactly ({ host, user }: hmAspect));
  homeAspect = take.exactly ({ home }: hmAspect);
in
{
  den.aspects.base.provides = {
    user.includes = [ homeUserAspect ];
    home.includes = [ homeAspect ];
  };
}
