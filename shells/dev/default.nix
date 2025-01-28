{
  lib,
  pkgs,
  inputs,
  namespace,
  mkShell,
  ...
}:
mkShell {
  packages = with pkgs; [
  ];
}
