{
  den.default = {
    os = { pkgs, ... }: {
      environment.systemPackages = [ pkgs.coreutils ];
    };

    homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.coreutils ];
    };
  };
}
