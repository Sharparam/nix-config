{
  programs.telegram = {
    darwin = {
      homebrew = {
        masApps = {
          "Telegram" = 747648890;
        };
      };
    };

    homeManager = {
      lib,
      pkgs,
      ...
    }:
      lib.mkIf (!pkgs.stdenv.hostPlatform.isDarwin) {
        home.packages = [pkgs.telegram-desktop];
      };
  };
}
