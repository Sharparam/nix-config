{
  den.aspects.base = {
    homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.bind.dnsutils ];
    };
  };
}
