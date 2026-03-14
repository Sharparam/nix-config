{
  inputs,
  den,
  lib,
  ...
}:
{
  _module.args.__findFile = den.lib.__findFile;

  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
  ];

  # other inputs may be defined at a module using them.
  # Does not have nixpkgs input(?)
  flake-file.inputs.den.url = lib.mkDefault "github:vic/den";

  den.default.includes = [
    den.provides.inputs'
    den.provides.self'
  ];
}
