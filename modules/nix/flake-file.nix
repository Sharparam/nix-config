{ lib, ... }:
{
  imports = [
    # These "auto follow" modules never seem to work properly
    # inputs.flake-file.flakeModules.allfollow
    # inputs.flake-file.flakeModules.nix-auto-follow
  ];

  flake-file.inputs.flake-file.url = lib.mkDefault "github:vic/flake-file";
}
