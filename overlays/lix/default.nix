{channels, ...}: final: prev: {
  inherit
    (final.lixPackageSets.latest.lix)
    nixpkgs-review
    # nix-direnv
    nix-eval-jobs
    nix-fast-build
    colmena
    ;
}
