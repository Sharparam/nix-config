{
  den.default = {
    os =
      { pkgs, ... }:
      {
        nixpkgs.overlays = [
          (_final: prev: {
            inherit (prev.lixPackageSets.latest)
              nixpkgs-review
              nix-direnv
              nix-eval-jobs
              nix-fast-build
              colmena
              ;
          })
        ];

        nix.package = pkgs.lixPackageSets.latest.lix;
      };
  };
}
