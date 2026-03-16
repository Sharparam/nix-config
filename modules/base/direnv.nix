{ lib, ... }:
let
  inherit (lib) mkDefault;

  homeAspect = {
    homeManager =
      { pkgs, ... }:
      {
        programs.direnv = {
          enable = true;
          mise.enable = true;
          nix-direnv = {
            enable = true;
            package = mkDefault pkgs.lixPackageSets.latest.nix-direnv;
          };
          config = {
            global = {
              load_dotenv = true;
              strict_env = true;
            };
          };
        };
      };
  };
in
{
  den.aspects.base.provides = {
    user = homeAspect;
    home = homeAspect;
  };
}
