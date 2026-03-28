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

      <programs/etcher>
      <programs/firefox>
      <programs/google-chrome>
      <programs/obs>
      <programs/skhd>
      <programs/steermouse>
      <programs/sweet-home3d>
    ];

    darwin =
      { pkgs, ... }:
      {
        system.stateVersion = 6;
        environment.systemPath = [ "/opt/homebrew/bin" ];

        environment.systemPackages = [ pkgs.local.fix-keyboard ];
      };

    provides.to-users = {
      includes = [
        <desktops/paneru>
        <work>
      ];

      homeManager = {
        programs.ghostty.settings.font-size = 14;

        # vscode.fhs doesn't work on nix-darwin
        programs.vscode.enable = false;

        home.stateVersion = "25.11";
      };
    };
  };
}
