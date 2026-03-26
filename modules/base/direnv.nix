{ inputs, lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  flake-file.inputs.direnv-instant = {
    url = "github:Mic92/direnv-instant";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.base = {
    homeManager =
      { pkgs, ... }:
      {
        imports = [ inputs.direnv-instant.homeModules.direnv-instant ];

        programs = {
          direnv = {
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

          direnv-instant = {
            enable = true;
          };
        };
      };
  };
}
