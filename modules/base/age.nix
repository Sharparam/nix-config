let
  packages =
    pkgs:
    builtins.attrValues {
      inherit (pkgs)
        rage
        age-plugin-yubikey
        ;
    };
in
{
  den.aspects.base = {
    includes = [
      (
        { home }:
        {
          homeManager =
            { pkgs, ... }:
            {
              home.packages = packages pkgs;
            };
        }
      )
    ];

    os =
      { pkgs, ... }:
      {
        environment.systemPackages = packages pkgs;
      };

    homeManager = {
      home.shellAliases = {
        age = "rage";
      };
    };
  };
}
