{
  programs.discord = {
    homeManager =
      { lib, ... }:
      {
        catppuccin.vesktop.enable = false;
        programs.vesktop = {
          enable = lib.mkDefault true;
        };
      };
  };
}
