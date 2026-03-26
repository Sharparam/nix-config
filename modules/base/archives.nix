# Utilities for dealing with archives
{
  den.aspects.base = {
    os =
      { pkgs, ... }:
      {
        environment.systemPackages = builtins.attrValues {
          inherit (pkgs)
            lsar
            unar
            ;
        };
      };

    darwin = {
      homebrew.masApps = {
        "The Unarchiver" = 425424353;
      };
    };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = builtins.attrValues {
          inherit (pkgs)
            lsar
            unar
            ;
        };
      };
  };
}
