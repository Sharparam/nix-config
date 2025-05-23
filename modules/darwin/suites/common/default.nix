{
  lib,
  pkgs,
  inputs,
  namespace,
  options,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.suites.common;
  rev = with inputs; self.rev or self.dirtyRev or null;
in
{
  options.${namespace}.suites.common = with types; {
    enable = mkEnableOption "Whether or not to enable the common configuration.";
  };

  config = mkIf cfg.enable {
    system.configurationRevision = rev;
    environment.systemPackages = with pkgs; [
      snix.scripts
      # TODO: Not supported on nix-darwin
      # catppuccin-cursors.frappeDark
    ];

    programs.zsh = enabled;

    ${namespace} = {
      nix = enabled;

      system = {
        fonts = enabled;
        interface = enabled;
        input = enabled;
      };

      security = {
        age = enabled;
        gpg = enabled;
        sudo = enabled;
      };

      services = {
        openssh = enabled;
      };

      tools = {
        homebrew = enabled;
      };
    };
  };
}
