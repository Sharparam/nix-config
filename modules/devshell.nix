{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = builtins.attrValues {
          inherit (pkgs)
            just
            nh
            oxfmt
            oxlint
            ;
        };
      };
    };
}
