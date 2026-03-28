{
  programs.podman = {
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
