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

            nixVersions = throw "CppNix bad, use Lix instead";
            lixPackageSets = prev.lixPackageSets.extend (
              finalSet: prevSet: {
                lix_2_93 = throw "Upgrade to Lix 2.94 or newer";
              }
            );
          })
        ];

        nix.package = pkgs.lixPackageSets.latest.lix;
      };
  };
}
