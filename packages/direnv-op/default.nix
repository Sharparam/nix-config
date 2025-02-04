{
  lib,
  pkgs,
  stdenv,
  ...
}:
stdenv.mkDerivation {
  pname = "direnv-op";
  version = "0-unstable-2023-05-23";

  src = pkgs.fetchFromGitHub {
    owner = "venkytv";
    repo = "direnv-op";
    rev = "db976ce107a2f58fb7465a7d2f0858a37b32e1f1";
    hash = "sha256-2lejN0oDbssTO1Cz6zneiYIA9Gbj4r2KE1bfmzfF3F4=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/direnv-op
    cp $src/oprc.sh $out/share/direnv-op
    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/venkytv/direnv-op";
    description = "direnv library to load secrets from 1Password";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
}
