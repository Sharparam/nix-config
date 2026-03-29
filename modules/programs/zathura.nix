{
  programs.zathura = {
    homeManager = {
      programs.zathura = {
        enable = true;
        options = {
          selection-clipboard = "clipboard";
          statusbar-home-tilde = true;
          window-title-home-tilde = true;
        };
      };
    };
  };
}
