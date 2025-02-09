{
  lib,
  stdenv,
  ...
}:
stdenv.mkDerivation (final: {
  pname = "sketchybarhelper";
  version = "0-unstable-2024-05-06";

  src = lib.cleanSource ./.;

  meta = {
    homepage = "https://github.com/FelixKratz/SketchyBarHelper";
    license = lib.licenses.gpl3;
    mainProgram = "sketchyhelper";
    platforms = lib.platforms.darwin;
  };
})
