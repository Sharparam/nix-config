{
  lib,
  pkgs,
  mkShell,
  ...
}:
mkShell {
  packages = with pkgs; [
    (lua5_4.withPackages (ps: with ps; [snix.sbarlua]))
  ];

  meta = {
    platforms = lib.platforms.darwin;
  };
}
