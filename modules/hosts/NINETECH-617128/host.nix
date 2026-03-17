{ __findFile, ... }:
let
  hostname = "NINETECH-617128";
in
{
  den.hosts.aarch64-darwin.${hostname} = {
    users.sharparam = {
      email = "adam.hellberg@ninetech.com";
    };
  };

  den.aspects.${hostname} = {
    includes = [
      <base>
      <work>

      <apps/dropbox>
      <apps/etcher>
      <apps/firefox>
      <apps/google-chrome>
      <apps/obs>
      <apps/skhd>
      <apps/steermouse>
      <apps/sweet-home3d>
    ];

    darwin =
      { pkgs, ... }:
      {
        system.stateVersion = 6;
        environment.systemPath = [ "/opt/homebrew/bin" ];

        environment.systemPackages = [ pkgs.local.fix-keyboard ];
      };

    homeManager = {
      programs.ghostty.settings.font-size = 14;

      # vscode.fhs doesn't work on nix-darwin
      programs.vscode.enable = false;

      home.stateVersion = "24.11";
    };
  };
}
