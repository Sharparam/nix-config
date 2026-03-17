{
  den.aspects.base = {
    homeManager = {
      programs.mergiraf = {
        enable = true;
        enableGitIntegration = true;
        enableJujutsuIntegration = true;
      };

      programs.jujutsu.settings.ui.merge-editor = "mergiraf";
    };
  };
}
