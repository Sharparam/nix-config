{
  den.aspects.base = {
    homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.magic-wormhole ];
    };
  };
}
