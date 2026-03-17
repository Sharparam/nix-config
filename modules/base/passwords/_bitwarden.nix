{
  den.aspects.base = {
    os =
      { pkgs, ... }:
      {
        environment.systemPackages = [
          pkgs.bitwarden-cli
        ];
      };

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [
          pkgs.bitwarden-desktop
        ];
      };

    darwin = {
      homebrew.casks = [ "bitwarden" ];
    };
  };
}
