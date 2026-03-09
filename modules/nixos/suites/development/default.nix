{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.suites.development;
  # apps = {
  #   vscode.enable = true;
  #   yubikey.enable = true;
  # };
  # cli-apps = {
  #   tmux.enable = true;
  #   neovim.enable = true;
  #   yubikey.enable = true;
  #   prisma.enable = true;
  #   mods.enable = true;
  # };
in
{
  options.${namespace}.suites.development = {
    enable = mkEnableOption "Whether or not to enable common development configuration.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      # inherit apps cli-apps;

      # tools = {
      #   direnv.enable = true;
      # };

      # virtualisation = {
      #   podman.enable = true;
      # };
    };
  };
}
