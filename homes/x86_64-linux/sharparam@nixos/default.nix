_:
{
  snix = {
    suites = {
      common.enable = true;
    };

    tools.ssh.enable = true;

    apps = {
      ghostty.enable = true;
    };
  };

  home.stateVersion = "24.11";
}
