{
  lib,
  stdenv,
  meson,
  ninja,
  pkg-config,
}:
stdenv.mkDerivation (final: {
  pname = "sketchyhelpers";
  version = "0-unstable-2025-02-09";

  src = lib.cleanSource ./.;

  mesonBuildType = "release";

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
  ];

  enableParallelBuilding = true;

  meta = {
    homepage = "https://github.com/FelixKratz/SketchyBarHelper";
    license = lib.licenses.gpl3;
    mainProgram = "sketchyhelper";
    platforms = lib.platforms.darwin;
  };
})
