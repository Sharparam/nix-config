{
  lib,
  pkgs,
  stdenv,
  ...
}:
let
in
stdenv.mkDerivation (finalAttrs: {
  pname = "nonicons";
  version = "0-unstable-2024-12-12";

  src = pkgs.fetchFromGitHub {
    owner = "ya2s";
    repo = "nonicons";
    rev = "5f56cf09167d2dcf5520bc0399f7019a7fea65d3";
    hash = "sha256-U8NilXnr5HNZdmYB2xpMak5B8BQ/9ZnA8VktJsngB4M=";
  };

  yarnOfflineCache = pkgs.fetchYarnDeps {
    yarnLock = finalAttrs.src + "/yarn.lock";
    hash = "sha256-EDL24LXu4lHzybUOB5LBL870rjToieHvjpx4kqSaNjc=";
  };

  nativeBuildInputs = with pkgs; [
    yarnConfigHook
    yarnBuildHook
    yarnInstallHook
    nodejs
  ];

  yarnBuildScript = "update";

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/fonts/TTF/nonicons
    cp $src/dist/nonicons.ttf $out/share/fonts/TTF/nonicons
    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/ya2s/nonicons";
    description = "A next-generation icon set for developers that extends octicons.";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
})
