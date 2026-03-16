{
  den.aspects.apps.provides.linqpad = {
    darwin =
      { pkgs, ... }:
      {
        environment.systemPackages =
          let
            dotnetPackages = pkgs.dotnetCorePackages;
            net10 = dotnetPackages.sdk_10_0;
            net8 = dotnetPackages.sdk_8_0;
          in
          [
            (dotnetPackages.combinePackages [
              net10
              net8
            ])
          ];
      };
  };
}
