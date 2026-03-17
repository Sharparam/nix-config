{
  lib,
  stdenv,
  fetchFromGitHub,
  ...
}:
stdenv.mkDerivation {
  pname = "catppuccin-zsh-fsh";
  version = "0-unstable-2026-03-16";

  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "zsh-fsh";
    rev = "a9bdf479f8982c4b83b5c5005c8231c6b3352e2a";
    hash = "sha256-WeqvsKXTO3Iham+2dI1QsNZWA8Yv9BHn1BgdlvR8zaw=";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/zsh-fsh/themes
    cp $src/themes/* $out/share/zsh-fsh/themes
    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/catppuccin/zsh-fsh";
    description = "Soothing pastel theme for fast-syntax-highlighting";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
}
