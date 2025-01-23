{
  lib,
  pkgs,
  namespace,
  options,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.suites.development;
  # apps = {
  #   vscode = enabled;
  #   yubikey = enabled;
  # };
  # cli-apps = {
  #   tmux = enabled;
  #   neovim = enabled;
  #   yubikey = enabled;
  #   prisma = enabled;
  #   mods = enabled;
  # };
in
{
  options.${namespace}.suites.development = with types; {
    enable = mkBoolOpt false "Whether or not to enable common development configuration.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      # inherit apps cli-apps;

      # tools = {
      #   direnv = enabled;
      # };

      # virtualisation = {
      #   podman = enabled;
      # };
    };
  };
}
