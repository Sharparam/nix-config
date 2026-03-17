{ lib, ... }:
{
  # Does not have a nixpkgs input
  flake-file.inputs.systems.url = lib.mkDefault "github:nix-systems/default";

  # systems = lib.systems.flakeExposed;
  systems = [
    "x86_64-linux"
    "aarch64-darwin"
  ];
}
