{ inputs, lib, ... }:
{
  flake-file.inputs.nur = {
    url = lib.mkDefault "github:nix-community/NUR";
    inputs.nixpkgs.follows = lib.mkDefault "nixpkgs";
  };

  den.default = {
    includes = [
      (
        { _home }:
        {
          homeManager.nixpkgs.overlays = [ inputs.nur.overlays.default ];
        }
      )
    ];

    nixos.imports = [ inputs.nur.modules.nixos.default ];
  };
}
