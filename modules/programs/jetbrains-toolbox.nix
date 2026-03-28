{
  programs.jetbrains-toolbox = {
    darwin = {
      # environment.systemPackages = [
      #   pkgs.jetbrains-toolbox
      # ];

      homebrew = {
        casks = [ "jetbrains-toolbox" ];
      };
    };
  };
}
