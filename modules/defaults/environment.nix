{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  den.default = {
    nixos = {
      environment.localBinInPath = true;
    };
    homeManager = {
      home.sessionPath = mkDefault [ "$HOME/.local/bin" ];
    };
  };
}
