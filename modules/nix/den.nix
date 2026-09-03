{
  inputs,
  den,
  lib,
  ...
}:
let
  nixClass =
    { class, aspect-chain }:
    den.batteries.forward {
      each = [
        "nixos"
        "homeManager"
      ];
      fromClass = _: "nix";
      intoClass = lib.id;
      intoPath = _: [
        "nix"
        "settings"
      ];
      fromAspect = _: lib.head aspect-chain;
      adaptArgs = lib.id;
    };
in
{
  _module.args.__findFile = den.lib.__findFile;

  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
  ];

  # other inputs may be defined at a module using them.
  # Does not have nixpkgs input(?)
  flake-file.inputs.den.url = "github:vic/den/v0.18.0";

  den.default.includes = [
    den.provides.inputs'
    den.provides.self'
  ];

  den.schema.user = {
    includes = [
      den.provides.mutual-provider
      nixClass
    ];
  };
}
