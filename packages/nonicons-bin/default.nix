{
  lib,
  pkgs,
  stdenv,
  ...
}:
let
  # Fetched at 2025-02-02T18:13:00T+01:00
  url = "https://github.com/ya2s/nonicons/raw/5f56cf09167d2dcf5520bc0399f7019a7fea65d3/dist/nonicons.ttf";
in
stdenv.mkDerivation {
  pname = "nonicons-bin";
  version = "1.0.0";

  src = pkgs.fetchurl {
    url = url;
    sha256 = "sha256-25k4k7IUzmrYO1TF4ErDia1VT0vMxqQZuWviiesU1qc=";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/fonts/TTF/nonicons
    cp $src $out/share/fonts/TTF/nonicons
    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/ya2s/nonicons";
    description = "nonicons font (binary package)";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
}
