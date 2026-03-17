{ lib, ... }:
let
  overlay = final: prev: {
    inherit (prev.lixPackageSets.latest)
      nixpkgs-review
      # https://git.lix.systems/lix-project/lix/issues/980
      # nix-direnv
      nix-eval-jobs
      nix-fast-build
      # nurl
      colmena
      ;

    comma = prev.comma.override {
      nix = final.lixPackageSets.latest.lix;
    };

    # Sadly we can't do this if using devenv since it's hardcoded to use CppNix
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
