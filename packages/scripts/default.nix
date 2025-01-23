{ stdenv, ... }:
stdenv.mkDerivation {
  name = "scripts";
  src = ./bin;
  installPhase = ''
    mkdir -p $out/bin
    cp * $out/bin
  '';
}
