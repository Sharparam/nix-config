{
  den.aspects.base = {
    homeManager = {
      programs.nix-your-shell = {
        enable = true;
        nix-output-monitor.enable = true;
      };
    };
  };
}
