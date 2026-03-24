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
  flake-file.inputs.den.url = "github:vic/den/244d16234ba8154e0fd2b45982bd475b87de0573";

  den.default.includes = [
    den.provides.inputs'
    den.provides.self'
  ];

  den.ctx.user = {
    includes = [
      den.provides.mutual-provider
    ];
  };
}
