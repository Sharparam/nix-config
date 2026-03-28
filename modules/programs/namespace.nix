{ inputs, ... }:
{
  imports = [ (inputs.den.namespace "programs" false) ];
}
