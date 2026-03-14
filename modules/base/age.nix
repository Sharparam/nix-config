{
  den.aspects.base = {
    os =
      { pkgs, ... }:
      {
        environment.systemPackages = builtins.attrValues {
          inherit (pkgs)
            rage
            age-plugin-yubikey
            ;
        };
      };
  };
}
