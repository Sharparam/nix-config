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

      <ssh/home>

      <apps/dropbox>
      <apps/etcher>
      <apps/google-chrome>
      <apps/skhd>
      <apps/steermouse>
      <apps/sweet-home3d>
    ];

    # TODO: Enable apps
    # archetypes = {
    #   work.enable = true;
    # };
    # apps = {
    #   etcher.enable = true;
    #   # linqpad.enable = true;
    #   obs.enable = true;
    #   sweet-home3d.enable = true;
    # };

    darwin = {
      system.stateVersion = 6;
      environment.systemPath = [ "/opt/homebrew/bin" ];
    };

    homeManager = {
      programs.ghostty.settings.font-size = 14;

      # vscode.fhs doesn't work on nix-darwin
      programs.vscode.enable = false;

      home.stateVersion = "24.11";
    };
  };
}
