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
      devenv = enabled;
      git = {
        enable = true;
        use1Password = true;
        credentialHelper = "libsecret";
        askPass = "/usr/bin/ksshaskpass";
      };
      home-manager = enabled;
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
