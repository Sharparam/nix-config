{
  den.aspects.apps.provides.linqpad = {
    darwin =
      { pkgs, ... }:
      {
        environment.systemPackages =
          let
            net10 = pkgs.dotnetCorePackages.sdk_10_0;
            net8 = pkgs.dotnetCorePackages.sdk_8_0;
          in
          [
            (pkgs.combinePackages [
              net10
              net8
            ])
          ];
      };
  };
}
