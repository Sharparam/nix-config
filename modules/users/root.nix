{ __findFile, ... }:
{
  den.aspects.root = {
    includes = [
      <nix-allowed-user>
      <nix-trusted-user>
    ];
  };
}
