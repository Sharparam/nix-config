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
      home-manager = enabled;
    };
  };

  home.packages = with pkgs; [
    alejandra
    cachix
    deadnix
    nixd
    nixfmt-rfc-style
    statix
  ];

  services.lorri.enable = true;

  home.stateVersion = "25.11";
}
