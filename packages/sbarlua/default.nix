# https://github.com/khaneliman/khanelinix/blob/main/packages/sbarlua/default.nix
# https://github.com/FelixKratz/SbarLua/pull/45
{
  lib,
  gcc,
  readline,
  lua5_4,
  fetchFromGitHub,
  ...
}: let
  lua = lua5_4;
in
  lua.pkgs.buildLuaPackage {
    pname = "sbarlua";
    version = "0-unstable-2024-08-12";

    src = fetchFromGitHub {
      owner = "FelixKratz";
      repo = "SbarLua";
      rev = "437bd2031da38ccda75827cb7548e7baa4aa9978";
      hash = "sha256-F0UfNxHM389GhiPQ6/GFbeKQq5EvpiqQdvyf7ygzkPg=";
    };

    nativeBuildInputs = [
      gcc
    ];

    buildInputs = [
      readline
    ];

    installPhase = ''
      runHook preInstall
      install -Dm755 bin/sketchybar.so $out/lib/lua/${lua.luaversion}/sketchybar.so
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
