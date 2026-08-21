{ lib, ... }:
let
  inherit (lib) mkDefault mkIf;
in
{
  programs.tailscale = {
    nixos = {
      services.tailscale = {
        enable = mkDefault true;
      };
    };
    darwin = {
      homebrew = {
        casks = [ "tailscale-app" ];
      };
    };
    homeManager =
      { pkgs, ... }:
      let
        isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
      in
      mkIf (!isDarwin) {
        services.tailscale-systray.enable = mkDefault true;
      };
  };
}
