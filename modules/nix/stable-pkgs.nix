{ inputs, ... }:
let
  overlay = final: prev: {
    stable = import inputs.nixpkgs-stable { inherit (prev.stdenv.hostPlatform) system; };
  };
in
{
  flake-file.inputs.nixpkgs-stable.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.zst";

  den.default = {
    includes = [
      (
        { home }:
        {
          homeManager = {
            nixpkgs.overlays = [ overlay ];
          };
        }
      )
    ];

    os = {
      nixpkgs.overlays = [ overlay ];
    };
  };
}
