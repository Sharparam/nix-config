{ __findFile, ... }:
{
  den.aspects.sharparam = {
    includes = [
      <sharparam/gpg>

      <nix-allowed-user>
      <nix-trusted-user>
      <den/primary-user>
      (<den/user-shell> "zsh")

      <base>
      <base/user>

      <catppuccin>
      <ssh/home>
      <dev>
    ];

    darwin = {
      # TODO: Configure better? Without hardcoding username
      system.defaults.screencapture.location = "/Users/sharparam/Pictures/screenshots/";
    };

    homeManager = {
      home.file =
        let
          profile = ../../../assets/sharparam/profile.png;
        in
        {
          ".face".source = profile;
          "Pictures/profile.png".source = profile;
          "Pictures/screenshots/.keep".text = "";
          "repos/.keep".text = "";
        };
    };
  };
}
