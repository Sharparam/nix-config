{
  lib,
  stdenvNoCC,
  ...
}:
let
  images = builtins.attrNames (builtins.readDir ./wallpapers);
  mkWallpaper =
    name: src:
    let
      fileName = builtins.baseNameOf src;
      pkg = stdenvNoCC.mkDerivation {
        inherit name src;
        dontUnpack = true;
        installPhase = ''
          cp $src $out
        '';
        passthru = {
          inherit fileName;
        };
      };
    in
    pkg;
  names = builtins.map lib.snowfall.path.get-file-name-without-extension images;
  wallpapers = lib.foldl (
    acc: image:
    let
      filenameRegex = "(.*)\\.(.*)$";
      splitFileExtension =
        file:
        let
          match = builtins.match filenameRegex file;
        in
        assert lib.assertMsg (match != null) "wallpapers: File must have an extension to split.";
        match;
      hasAnyFileExtension =
        file:
        let
          match = builtins.match filenameRegex (builtins.toString file);
        in
        match != null;
      filenameWithoutExtension =
        path:
        let
          filename = builtins.baseNameOf path;
        in
        if hasAnyFileExtension filename then
          builtins.concatStringsSep "" (lib.init (splitFileExtension filename))
        else
          filename;
      name = filenameWithoutExtension image;
    in
    acc // { "${name}" = mkWallpaper name (./wallpapers + "/${image}"); }

  ) { } images;
  installTarget = "$out/share/wallpapers";
in
stdenvNoCC.mkDerivation {
  name = "wallpapers";
  src = ./wallpapers;
  installPhase = ''
    mkdir -p ${installTarget}
    find * -type f -mindepth 0 -maxdepth 0 -exec cp ./{} ${installTarget}/{} ';'
  '';
  passthru = {
    inherit names;
  }
  // wallpapers;
}
