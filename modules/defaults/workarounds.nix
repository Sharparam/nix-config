{
  den.default = {
    darwin = {
      nixpkgs.overlays = [
        # TODO: kvazaar (at least the tests) is broken on Darwin due to weird code signing issues
        # See: https://github.com/NixOS/nixpkgs/issues/514347
        # Fix copied from https://github.com/sheeeng/nix/commit/beda5cec512ef68b57bf853ddac21953844aa404
        (final: prev: {
          kvazaar = prev.kvazaar.overrideAttrs (
            _old:
            final.lib.optionalAttrs final.stdenv.hostPlatform.isDarwin {
              doCheck = false;
            }
          );

          # There seems to be a similar issue with chromaprint, so disable tests here as well
          chromaprint = prev.chromaprint.overrideAttrs (
            _old:
            final.lib.optionalAttrs final.stdenv.hostPlatform.isDarwin {
              doCheck = false;
            }
          );
        })
      ];
    };
  };
}
