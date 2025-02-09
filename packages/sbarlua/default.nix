# https://github.com/khaneliman/khanelinix/blob/main/packages/sbarlua/default.nix
# https://github.com/FelixKratz/SbarLua/pull/45

{
  lib,
  gcc,
  readline,
  darwin,
  lua54Packages,
  fetchFromGitHub,
  ...
}:
lua54Packages.buildLuaPackage {
  name = "sbarlua";
  pname = "sbarlua";
  version = "0-unstable-2024-08-12";
  # name = "lua${lua.luaversion}-" + pname + "-" + version;

  src = fetchFromGitHub {
    owner = "FelixKratz";
    repo = "SbarLua";
    rev = "437bd2031da38ccda75827cb7548e7baa4aa9978";
    hash = "sha256-F0UfNxHM389GhiPQ6/GFbeKQq5EvpiqQdvyf7ygzkPg=";
  };

  buildInputs = [
    gcc
    readline
    darwin.apple_sdk.frameworks.CoreFoundation
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/lib
    mv bin/sketchybar.so $out/lib/sketchybar.so
    runHook postInstall
  '';

  meta = {
    description = "A Lua API for SketchyBar";
    homepage = "https://github.com/FelixKratz/SbarLua";
    license = lib.licenses.gpl3Only;
    mainProgram = "sbarlua";
    platforms = lib.platforms.darwin;
  };
}
