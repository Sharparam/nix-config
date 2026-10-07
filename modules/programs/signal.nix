{
  programs.signal = {
    darwin = {
      homebrew.casks = [ "signal" ];
    };

    homeManager =
      { lib, pkgs, ... }:
      lib.mkIf (!pkgs.stdenv.hostPlatform.isDarwin) {
        home.packages = [ pkgs.signal-desktop ];
      };
  };
}
