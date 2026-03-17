{
  den.aspects.apps.provides.podman = {
    darwin = {
      homebrew = {
        brews = [
          "podman"
          "podman-compose"
          "podman-tui"
        ];
        casks = [ "podman-desktop" ];
      };
    };
  };
}
