{ __findFile, ... }:
{
  den.aspects.root = {
    includes = [
      <nix-allowed-user>
      <nix-trusted-user>
      (<den/user-shell> "zsh")

      # <base>
    ];
  };
}
