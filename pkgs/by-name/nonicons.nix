{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchYarnDeps,
  nodejs,
  yarnBuildHook,
  yarnConfigHook,
  yarnInstallHook,
  ...
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "nonicons";
  version = "0-unstable-2024-12-12";

  src = fetchFromGitHub {
    owner = "ya2s";
    repo = "nonicons";
    rev = "5f56cf09167d2dcf5520bc0399f7019a7fea65d3";
    hash = "sha256-U8NilXnr5HNZdmYB2xpMak5B8BQ/9ZnA8VktJsngB4M=";
  };

  yarnOfflineCache = fetchYarnDeps {
    yarnLock = finalAttrs.src + "/yarn.lock";
    hash = "sha256-EDL24LXu4lHzybUOB5LBL870rjToieHvjpx4kqSaNjc=";
  };

  nativeBuildInputs = [
    nodejs
    yarnBuildHook
    yarnConfigHook
    yarnInstallHook
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
