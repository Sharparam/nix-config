{
  den.aspects.apps.provides.jetbrains-rider = {
    darwin =
      { pkgs, ... }:
      {
        environment.systemPackages = [
          pkgs.jetbrains.rider
        ];
      };
  };
}
