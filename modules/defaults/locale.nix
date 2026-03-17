{ inputs, lib, ... }:
{
  flake-file.inputs.locale-en_se = {
    url = lib.mkDefault "github:Sharparam/locale-en_se/main";
    inputs.nixpkgs.follows = lib.mkDefault "nixpkgs";
  };

  den.default = {
    nixos = {
      imports = [
        inputs.locale-en_se.nixosModules.default
      ];
    };
  };
}
