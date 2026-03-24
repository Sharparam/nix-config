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

      <apps/filen>
    ];

    darwin = {
      # TODO: Configure better? Without hardcoding username
      system.defaults.screencapture.location = "/Users/sharparam/Pictures/screenshots/";
    };

    homeManager =
      let
        sessionVariables = {
          ANSIBLE_NOCOWS = 1;
          BROWSER = "firefox";
          CMAKE_GENERATOR = "Ninja";
          DOTNET_CLI_TELEMETRY_OPTOUT = 1;
          MAKEFLAGS = "-j$(nproc)";
        };
      in
      {
        home = {
          inherit sessionVariables;

          file =
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

        systemd.user = { inherit sessionVariables; };
      };
  };
}
