{ inputs, ... }:
let
  overlay = final: prev: {
    stable = import inputs.nixpkgs-stable { inherit (prev.stdenv.hostPlatform) system; };
  };
in
{
  flake-file.inputs.nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";

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
