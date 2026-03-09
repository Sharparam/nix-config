{
  lib,
  pkgs,
  mkShell,
  ...
}:
mkShell {
  packages = [
    (pkgs.lua5_4.withPackages (ps: [ ps.snix.sbarlua ]))
  ];

  meta = {
    platforms = lib.platforms.darwin;
  };
}
