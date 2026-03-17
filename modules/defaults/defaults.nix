{ __findFile, lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  den.default = {
    includes = [
      <den/hostname>
    ];

    nixos.system.stateVersion = mkDefault "25.11";
    darwin.system.stateVersion = mkDefault 6;
    homeManager.home.stateVersion = mkDefault "25.11";
  };
}
