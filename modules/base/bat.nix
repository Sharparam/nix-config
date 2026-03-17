{
  den.aspects.base = {
    darwin = {
      environment.variables.HOMEBREW_BAT = "1";
    };

    homeManager = {
      programs.bat.enable = true;

      home.shellAliases = {
        cat = "bat --paging=never";
      };
    };
  };
}
