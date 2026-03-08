{
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
{
  snix = {
    tools = {
      atuin = enabled;
      bat = enabled;
      devenv = enabled;
      direnv = enabled;
      fd = enabled;
      fzf = enabled;
      git = {
        enable = true;
        use1Password = true;
        credentialHelper = "libsecret";
        askPass = "/usr/bin/ksshaskpass";
      };
      home-manager = enabled;
      mise = enabled;
      zoxide = enabled;
    };
  };

  home.packages = with pkgs; [
    alejandra
    cachix
    deadnix
    nixd
    nixfmt
    statix
  ];

  services.lorri.enable = true;

  home.stateVersion = "25.11";
}
