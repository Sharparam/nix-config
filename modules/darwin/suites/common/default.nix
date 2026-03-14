{
  lib,
  pkgs,
  inputs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.suites.common;
  rev = inputs.self.rev or inputs.self.dirtyRev or null;
in
{
  options.${namespace}.suites.common = {
    enable = mkEnableOption "Whether or not to enable the common configuration.";
  };

  config = mkIf cfg.enable {
    system.configurationRevision = rev;
    environment.systemPackages = [
      # TODO: Not supported on nix-darwin
      # pkgs.catppuccin-cursors.frappeDark
    ];

    programs.zsh.enable = true;

    ${namespace} = {
      nix.enable = true;

      system = {
        fonts.enable = true;
        interface.enable = true;
        input.enable = true;
      };

      security = {
        age.enable = true;
        gpg.enable = true;
        sudo.enable = true;
      };

      services = {
        openssh.enable = true;
      };

      tools = {
        homebrew.enable = true;
      };
    };
  };
}
