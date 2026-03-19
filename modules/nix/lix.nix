{ lib, ... }:
let
  overlay = final: prev: {
    inherit (prev.lixPackageSets.latest)
      # https://git.lix.systems/lix-project/lix/issues/980
      # nixpkgs-review
      # nix-direnv
      nix-eval-jobs
      nix-fast-build
      # nurl
      colmena
      ;

    # TODO: Fix to use Lix stuff
    # nixd = prev.nixd;

    comma = prev.comma.override {
      nix = final.lixPackageSets.latest.lix;
    };

    # cachix and devenv require CppNix for some reason
    # cachix = prev.cachix;
    # devenv = prev.devenv;

    # Still can't disable CppNix entirely :(
    # nixVersions = throw "CppNix bad, use Lix instead";
    lixPackageSets = prev.lixPackageSets.extend (
      finalSet: prevSet: {
        lix_2_93 = throw "Upgrade to Lix 2.94 or newer";
      }
    );
  };

  subs = {
    substituters = [
      "https://cache.lix.systems"
    ];

    trusted-public-keys = [
      "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
    ];
  };

  hmAspect =
    { home }:
    {
      homeManager.nixpkgs.overlays = [ overlay ];
    };
in
{
  den.default = {
    includes = [ hmAspect ];
    os =
      { pkgs, ... }:
      {
        nixpkgs.overlays = [ overlay ];

        nix = {
          package = pkgs.lixPackageSets.latest.lix;
          settings = subs;
        };
      };

    homeManager =
      { pkgs, ... }:
      {
        nix = {
          package = lib.mkDefault pkgs.lixPackageSets.latest.lix;
          settings = subs;
        };
      };
  };
}
