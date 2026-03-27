# Utilities for dealing with archives
{
  den.aspects.base = {
    os =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.unar ];
      };

    darwin = {
      homebrew.masApps = {
        "The Unarchiver" = 425424353;
      };
    };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.unar ];
      };
  };
}
