{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        nativeBuildInputs = builtins.attrValues {
          inherit (pkgs)
            just
            nh
            ;
        };
      };
    };
}
