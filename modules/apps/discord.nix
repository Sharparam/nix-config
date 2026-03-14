{
  den.aspects.apps.provides.discord = {
    homeManager =
      { pkgs, lib, ... }:
      let
        vesktop = pkgs.vesktop.overrideAttrs (_old: {
          postConfigure = "";

          buildPhase = ''
            runHook preBuild

            pnpm build
            pnpm exec electron-builder \
              --dir \
              -c.asarUnpack="**/*.node" \
              -c.electronDist=${if pkgs.stdenv.hostPlatform.isDarwin then "." else "electron-dist"} \
              -c.electronVersion=${pkgs.electron.version} \
              ${lib.optionalString pkgs.stdenv.hostPlatform.isDarwin "-c.mac.identity=null"}

            runHook postBuild
          '';
        });
      in
      {
        home.packages = [ vesktop ];
      };
  };
}
