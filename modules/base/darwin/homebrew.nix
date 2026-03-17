{
  den.aspects.base.darwin =
    { pkgs, ... }:
    {
      environment.variables = {
        HOMEBREW_NO_ANALYTICS = "1";
        HOMEBREW_NO_INSECURE_REDIRECT = "1";
      };

      environment.systemPackages = [
        pkgs.mas
      ];

      homebrew = {
        enable = true;

        global = {
          autoUpdate = true;
          # brewfile = false;
          # lockfiles = !config.homebrew.global.brewfile;
        };

        onActivation = {
          autoUpdate = false;
          cleanup = "zap";
          upgrade = false;
        };

        taps = [ "homebrew/services" ];
      };
    };
}
