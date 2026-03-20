{
  den.aspects.ai.provides.claude = {
    darwin = {
      homebrew.casks = [ "claude" ];
    };

    homeManager = {
      programs.claude-code = {
        enable = true;
      };
    };
  };
}
