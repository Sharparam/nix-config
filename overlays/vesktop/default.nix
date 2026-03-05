{ ... }:
final: prev: {
  vesktop = prev.vesktop.overrideAttrs (old: {
    postConfigure = "";

    buildPhase = ''
      runHook preBuild

      pnpm build
      pnpm exec electron-builder \
        --dir \
        -c.asarUnpack="**/*.node" \
        -c.electronDist=${if final.stdenv.hostPlatform.isDarwin then "." else "electron-dist"} \
        -c.electronVersion=${final.electron.version} \
        ${final.lib.optionalString final.stdenv.hostPlatform.isDarwin "-c.mac.identity=null"}

      runHook postBuild
    '';
  });
}
