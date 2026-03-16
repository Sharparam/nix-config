{ lib, ... }:
{
  flake-file.inputs.darwin = {
    url = lib.mkDefault "github:nix-darwin/nix-darwin";
    inputs.nixpkgs.follows = lib.mkDefault "nixpkgs";
  };
}
