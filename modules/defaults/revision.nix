{ inputs, ... }:
let
  rev = inputs.self.rev or inputs.self.dirtyRev or "<unknown>";
in
{
  den.default.os = {
    system.configurationRevision = rev;
  };
}
