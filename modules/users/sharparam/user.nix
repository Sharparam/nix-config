{ __findFile, ... }:
{
  den.aspects.sharparam = {
    includes = [
      <nix-allowed-user>
      <nix-trusted-user>
      <den/define-user>
      <den/primary-user>
      (<den/user-shell> "zsh")

      <sharparam/gpg>
      <sharparam/secrets>

      <base>
      <base/user>

      <catppuccin>
      <ssh/home>
      <dev>

      <ai/claude>
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
