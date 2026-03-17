{
  lib,
  writeShellApplication,
}:
writeShellApplication {
  name = "fix-keyboard";

  text = builtins.readFile ./fix-keyboard.sh;

  meta = {
    homepage = "https://github.com/Sharparam/nix-config";
    description = "Sharparam's personal script to fix keyboard layout on work laptop.";
    license = lib.licenses.mit;
    platforms = lib.platforms.darwin;
  };
}
