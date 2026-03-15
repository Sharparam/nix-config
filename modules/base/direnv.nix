{
  den.aspects.base = {
    homeManager =
      { pkgs, ... }:
      {
        programs.direnv = {
          enable = true;
          mise.enable = true;
          nix-direnv = {
            enable = true;
            package = pkgs.lixPackageSets.latest.nix-direnv;
          };
        };
      };
  };
}
